data "aws_iam_policy_document" "assume_role_policy_fargate" {
  statement {
    sid     = "AssumeRolePolicyForFargateRole"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "assume_role_policy_provisioner_instance" {
  statement {
    sid     = "AssumeRolePolicyForEC2Role"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "inline_policy_provisioner" {
  statement {
    sid = "InlinePolicyForConfluenceAndProvisionerInstance"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ssm:GetParameter*",
      "secretsmanager:GetSecretValue",
      "kms:Decrypt",
      "elasticfilesystem:DescribeFileSystems",
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientRootAccess"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "inline_policy_fargate" {
  statement {
    sid = "InlinePolicyForConfluenceMisc"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ssm:GetParameter*",
      "secretsmanager:GetSecretValue",
      "kms:Decrypt"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    sid = "InlinePolicyForConfluenceEFS"
    actions = [
      "elasticfilesystem:DescribeFileSystems",
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientRootAccess"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role" "task_definition_role" {
  name               = var.iam_task_definition_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_fargate.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]
  inline_policy {
    name   = "InlinePolicyForConfluence"
    policy = data.aws_iam_policy_document.inline_policy_fargate.json
  }

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "task",
      "definition",
      "execution",
      "role"
    ])
  }
}

resource "aws_iam_role" "provisioner_instance_role" {
  name               = var.iam_provisioner_instance_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_provisioner_instance.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonRDSFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]

  inline_policy {
    name   = "InlinePolicyForProvisionerInstance"
    policy = data.aws_iam_policy_document.inline_policy_provisioner.json
  }

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "provisioner",
      "instance",
      "role"
    ])
  }
}

resource "aws_iam_instance_profile" "provisioner_instance_profile" {
  name = var.iam_provisioner_instance_profile_name
  role = aws_iam_role.provisioner_instance_role.name
}
