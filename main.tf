

# --- VPC MODULE ---
module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

# --- KEY PAIR MODULE ---
module "key_pair" {
  source                  = "./modules/key_pair"
  key_name                = var.key_name
  private_key_output_path = var.private_key_output_path
}

# --- RDS MODULE ---
module "rds" {
  source     = "./modules/rds"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
  vpc_cidr   = var.vpc_cidr
  db_name    = var.db_name
  db_user    = var.db_user
}

# --- EC2 MODULE (WordPress) ---
module "ec2" {
  source             = "./modules/ec2"
  subnet_id          = module.vpc.public_subnet_ids[0]
  key_name           = module.key_pair.key_name
  security_group_ids = [module.vpc.allow_ssh_http_sg_id]

  db_host     = module.rds.db_endpoint
  db_name     = var.db_name
  db_user     = var.db_user
  db_password = module.rds.db_password
}
