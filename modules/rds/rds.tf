
#rds subnet
resource "aws_db_subnet_group" "rds_subnet" {
  name       = "rds-subnet"
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]
}
#RDS INSTANCE
resource "aws_db_instance" "rds_instance" {
  engine                    = "mysql"
  engine_version            = "8.0"
  skip_final_snapshot       = true
  final_snapshot_identifier = "my-final-snapshot"
  instance_class            = "db.t2.micro"
  allocated_storage         = 20
  identifier                = "my-rds-instance"
  db_name                   = "wordpress_db"
  username                  = "admin"
  password                  = "password"
  db_subnet_group_name      = aws_db_subnet_group.rds_subnet.id
  vpc_security_group_ids    = [aws_security_group.rds_security_group.id]

  tags = {
    Name = "rds Instance"
  }
}
# RDS security group
resource "aws_security_group" "rds_security_group" {
  name        = "rds-security-group"
  description = "Security group for RDS instance"
  vpc_id      = aws_vpc.wordpress_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.100.0.0/16"]
  }

  tags = {
    Name = "RDS Security Group"
  }
}