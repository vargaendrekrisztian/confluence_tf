data "aws_ssm_parameter" "db_password" {
  name            = var.container_db_passwd_name
  with_decryption = true
}

resource "aws_cloudwatch_log_group" "fargate_log_group" {
  count             = var.fargate_log_group_exists ? 0 : 1
  name              = join("-", [var.tag_prefix, "fargate", "log", "group"])
  retention_in_days = var.fargate_log_group_retention_days

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "fargate",
      "log",
      "group"
    ])
  }
}

resource "aws_ecs_cluster" "fargate_cluster" {
  name               = "ConfluenceFargateCluster"
  capacity_providers = ["FARGATE"]

  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"
      log_configuration {
        cloud_watch_log_group_name = var.fargate_log_group_exists ? join("-", [var.tag_prefix, "fargate", "log", "group"]) : aws_cloudwatch_log_group.fargate_log_group[0].name
      }
    }
  }

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 100
    base              = var.number_of_tasks
  }

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "fargate",
      "cluster"
    ])
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = "ConfluenceFargateService"
  requires_compatibilities = ["FARGATE"]

  execution_role_arn = var.task_def_execution_role_arn
  task_role_arn      = var.task_def_task_role_arn

  cpu          = var.container_cpu_constraint
  memory       = var.container_memory_constraint
  network_mode = "awsvpc"

  volume {
    name = "ConfluenceEFSContainerMount"

    efs_volume_configuration {
      file_system_id = var.container_volume_efs_id
    }
  }

  container_definitions = jsonencode([
    {
      name      = "ConfluenceContainer"
      image     = var.container_image
      cpu       = var.container_cpu_constraint
      memory    = var.container_memory_constraint
      essential = true
      portMappings = [
        {
          containerPort = 8090
        },
        {
          containerPort = 8091
        }
      ],
      mountPoints = [
        {
          sourceVolume  = "ConfluenceEFSContainerMount"
          containerPath = "/var/atlassian/application-data/confluence"
        }
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region        = var.region
          awslogs-group         = var.fargate_log_group_exists ? join("-", [var.tag_prefix, "fargate", "log", "group"]) : aws_cloudwatch_log_group.fargate_log_group[0].name
          awslogs-stream-prefix = "ConfluenceFargateService"
        }
      }
      environment = [
        { "name" : "ATL_PROXY_NAME", "value" : var.container_lb_dns_name },
        { "name" : "ATL_PROXY_PORT", "value" : "80" },
        { "name" : "ATL_TOMCAT_SCHEME", "value" : "http" },
        { "name" : "ATL_TOMCAT_SECURE", "value" : "false"},
        { "name" : "ATL_DB_TYPE", "value" : "postgresql" },
        { "name" : "ATL_JDBC_URL", "value" : join("", ["jdbc:postgresql://", var.container_db_url, "/", var.container_db_name]) },
        { "name" : "ATL_JDBC_USER", "value" : var.container_db_user },
        { "name" : "ATL_JDBC_PASSWORD", "value" : data.aws_ssm_parameter.db_password.value },
        { "name" : "ATL_LICENCE_KEY", "value" : var.licence_key }
      ]
    }
  ])

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "ConfluenceFargateService"
    ])
  }
}

resource "aws_ecs_service" "service" {
  name            = "ConfluenceFargateService"
  cluster         = aws_ecs_cluster.fargate_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn

  desired_count = var.number_of_tasks

  launch_type = "FARGATE"

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "ConfluenceContainer"
    container_port   = 8090
  }

  network_configuration {
    assign_public_ip = false
    subnets          = var.fargate_subnet_ids
    security_groups  = [var.server_security_group_id]
  }

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "fargate",
      "service"
    ])
  }
}

resource "local_file" "upload_user_data_playbook" {
  content = templatefile(
    "${path.root}/ansible_files/upload_user_data.yml.tpl",
    {
      source   = "user_test.sql"
      host     = element(split(":", var.container_db_url), 0)
      port     = element(split(":", var.container_db_url), 1)
      username = var.container_db_user
      dbname   = var.container_db_name
      password = data.aws_ssm_parameter.db_password.value
    }
  )
  filename = "${path.root}/ansible_files/upload_user_data.yml"
}

resource "time_sleep" "wait_5m_after_ecs_service" {
  depends_on      = [aws_ecs_service.service]
  create_duration = "5m"
}

resource "null_resource" "upload_user_data" {
  provisioner "local-exec" {
    working_dir = "./ansible_files"
    command     = "ansible-playbook -i inventory upload_user_data.yml"
  }

  depends_on = [
    local_file.upload_user_data_playbook,
    time_sleep.wait_5m_after_ecs_service
  ]
}
