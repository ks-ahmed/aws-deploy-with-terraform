module "ec2" {
    source = "./modules/ec2"
  
}

module "vpc" {
    source = "./modules/vpc"
  
}
module "rds" {
    source = "./modules/rds"
  
}
