variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
  description = "Map of public subnets"
}

variable "private_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
  description = "Map of private subnets"
}

locals {
  igw_tag_name = "wordpress-igw"
  nat_tag_name = "wordpress-nat"
  eip_domain = "vpc"
  public_tag_name = "public-route-table"
  private_tag_name = "private-route-table"
  vpc_tag_name = "wordpress-vpc"
  sg_name = "allow_ssh_http"
  sg_desc = "Allow SSH and HTTP inbound traffic"
  sg_tag_name = "allow_ssh_http"

}

variable "route_cidr_block" {
    type = string
    default = "0.0.0.0/0"
}
