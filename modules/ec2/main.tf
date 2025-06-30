resource "aws_instance" "wordpress" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/user_data.sh.tpl", {
    db_host     = var.db_host,
    db_name     = var.db_name,
    db_user     = var.db_user,
    db_password = var.db_password
  })

  tags = {
    Name = local.instance_tag_name
  }
}
