# CREDENTIALS
access_key_id     = "<AWS access key ID>"
secret_access_key = "<AWS secret access key>"

# MODULE ENABLEMENTS
networking           = true
iam                  = true
secret_ssm           = true
database             = true
key_pair             = true
provisioner_instance = true
ecr                  = true
efs                  = true
vpc_endpoints        = true
load_balancer        = true
confluence_fargate   = true

# NETWORKING
my_ip      = "46.107.76.83/32"
vpc_cidr   = "10.0.0.0/16"
tag_prefix = "confluence"
subnet_data = [
  {
    cidr_block        = "10.0.0.0/24"
    availability_zone = "eu-central-1a"
    public            = true
  },
  {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "eu-central-1b"
    public            = true
  },
  {
    cidr_block        = "10.0.2.0/24"
    availability_zone = "eu-central-1c"
    public            = true
  },
  {
    cidr_block        = "10.0.3.0/24"
    availability_zone = "eu-central-1a"
    public            = false
  },
  {
    cidr_block        = "10.0.4.0/24"
    availability_zone = "eu-central-1b"
    public            = false
  },
  {
    cidr_block        = "10.0.5.0/24"
    availability_zone = "eu-central-1c"
    public            = false
  },
  {
    cidr_block        = "10.0.6.0/24"
    availability_zone = "eu-central-1a"
    public            = false
  },
  {
    cidr_block        = "10.0.7.0/24"
    availability_zone = "eu-central-1b"
    public            = false
  },
  {
    cidr_block        = "10.0.8.0/24"
    availability_zone = "eu-central-1c"
    public            = false
  }
]

# SSM PARAMETER
db_passwd = "<database password>"

# DATABASE
db_allocated_storage = 10
db_engine            = "postgres"
db_engine_version    = "10.15"
db_instance_type     = "db.t2.micro"
db_passwd_name       = "/confluence/db_passwd"
db_port              = 5432
db_availability_zone = "eu-central-1a"
db_user              = "confluenceuser"
db_name              = "confluence"

# KEY PAIR
key_name = "confluencekey"

# PROVISIONER INSTANCE
provisioner_ami = "ami-05cafdf7c9f772ad2"

# ECR
ecr_repo_name            = "confluence_image_repo"
ecr_image_tag_mutability = "MUTABLE"
docker_image_name        = "atlassian/confluence-server"
docker_image_tag         = "7.13.3-adoptopenjdk11"
aws_account_id           = "<AWS account ID>"
region                   = "eu-central-1"

# IAM
iam_task_definition_role_name         = "task_definition_role"
iam_provisioner_instance_role_name    = "provisioner_instance_role"
iam_provisioner_instance_profile_name = "provisioner_instance_profile"

# EFS
efs_name = "container-efs"

# CONFLUENCE FARGATE
target_group_name                = "tg"
confluence_port                  = 8090
load_balancer_name               = "lb"
load_balancer_listener_port      = 80
fargate_log_group_exists         = false
fargate_log_group_name           = "fargate-logs"
fargate_log_group_retention_days = 1
cluster_name                     = "fargate-cluster"
number_of_tasks                  = 2
task_def_service_name            = "task-definition-service"
container_cpu_constraint         = 1024
container_memory_constraint      = 2048
container_name                   = "confluence"
licence_key                      = "<Licence key for Atlassian Confluence>"
