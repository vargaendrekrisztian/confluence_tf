variable "my_ip" {
  type = string

  validation {
    condition     = can(regex("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}/32", var.my_ip))
    error_message = "Invalid CIDR range for the your IP address. Valid format: <int 0-255>.<int 0-255>.<int 0-255>.<int 0-255>/32."
  }
}

variable "vpc_cidr" {
  type = string

  validation {
    condition     = can(regex("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}/\\d{1,2}", var.vpc_cidr))
    error_message = "Invalid CIDR range for the VPC. Valid format: <int 0-255>.<int 0-255>.<int 0-255>.<int 0-255>/<int 0-32>."
  }
}

variable "tag_prefix" {
  type = string
}

variable "subnet_data" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    public            = bool
  }))

  validation {
    condition     = alltrue([for item in var.subnet_data : can(regex("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}/\\d{1,2}", lookup(item, "cidr_block")))])
    error_message = "Invalid CIDR range for the VPC. Valid format: <int 0-255>.<int 0-255>.<int 0-255>.<int 0-255>/<int 0-32>."
  }
  validation {
    condition     = alltrue([for item in var.subnet_data : can(regex("[a-z]{2}-[a-z]+-\\d[a-z]", lookup(item, "availability_zone")))])
    error_message = "Invalid availability zone name. Valid format (regex): [a-z]{2}-[a-z]+-\\d[a-z]."
  }
}
