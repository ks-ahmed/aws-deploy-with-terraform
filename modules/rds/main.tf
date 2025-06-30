resource "random_password" "db" {
  length  = 16
  special = false
}

#rds subnet
resource "aws_db_subnet_group" "rds" {
  name       = local.rds_subnet_name
  subnet_ids = var.subnet_ids

  tags = {
   Name = local.rds_subnet_name
  }
}

resource "aws_security_group" "rds_sg" {
  name        = local.rds_sg_name
  description = local.rds_sg_desc
  vpc_id      = var.vpc_id

  ingress {
    description = "MySQL from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = local.rds_sg_name
  }
}

resource "aws_db_instance" "rds" {
  identifier              = var.identifier
  allocated_storage       = var.allocated_storage
  engine                  = local.rds_engine
  engine_version          = "8.0"
  instance_class          = var.instance_class
  db_subnet_group_name    = aws_db_subnet_group.rds.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_name                 = var.db_name
  username                = var.db_user
  password                = random_password.db.result
  skip_final_snapshot     = true
  publicly_accessible     = false

  tags = {
    Name = local.db_tag_name
  }
}


