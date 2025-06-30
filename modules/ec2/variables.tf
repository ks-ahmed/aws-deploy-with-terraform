variable "key_name" {
  type        = string
  description = "SSH key pair name"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to launch the instance"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to assign to the instance"
}

variable "db_host" {
  type        = string
  description = "Hostname or endpoint of the RDS DB instance"
}

variable "db_name" {
  type        = string
  description = "Database name for WordPress"
}

variable "db_user" {
  type        = string
  description = "Database username"
}

variable "db_password" {
  type        = string
  description = "Database password"
  sensitive   = true
}

variable "ami" {
  type = string
  default = "ami-044415bb13eee2391"
  
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

locals {
  instance_tag_name = "wordpress_server"
}