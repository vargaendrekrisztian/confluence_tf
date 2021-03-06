# CREDENTIALS
access_key_id     = "<Give your AWS access key ID>"
secret_access_key = "<Give your AWS secret access key>"

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
my_ip      = "<Give your own IP address>/32"
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
db_passwd = "<Give your database password>"

# DATABASE
db_allocated_storage = 10
db_instance_type     = "db.t2.micro"
db_availability_zone = "eu-central-1a"
db_user              = "confluenceuser"
db_name              = "confluence"

# KEY PAIR
key_name = "confluencekey"

# PROVISIONER INSTANCE
provisioner_ami = "ami-05cafdf7c9f772ad2"

# ECR
docker_image_name        = "atlassian/confluence-server"
docker_image_tag         = "7.13.3-adoptopenjdk11"
aws_account_id           = 367831582769
region                   = "eu-central-1"

# CONFLUENCE FARGATE
fargate_log_group_exists         = false
fargate_log_group_retention_days = 1
number_of_tasks                  = 2
container_cpu_constraint         = 1024
container_memory_constraint      = 2048
licence_key                      = "<Give your Atlassian Confluence licence key>"
