
variable "vpc_id" {
  type        = string
  description = "VPC ID where RDS is deployed"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block of the VPC for SG ingress"
  default     = "10.0.0.0/16"
}

variable "db_name" {
  type        = string
  default     = "wordpress_db"
}

variable "db_user" {
  type        = string
  default     = "admin"
}

locals {
  rds_subnet_name = "rds-subnet-group"
  rds_sg_name = "rds-sg"
  rds_sg_desc = "Security group for RDS instance"
  rds_engine = "mysql"
  db_tag_name = "wordpress-rds"

}

variable "identifier" {
  type = string
  default = "wordpress-db"
  
}

variable "allocated_storage" {
  type = number
  default = 20
  
}

variable "instance_class" {
  type = string
  default = "db.t3.micro"
}