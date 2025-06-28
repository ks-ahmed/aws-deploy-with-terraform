resource "aws_instance" "wordpress-terra" {
  ami                         = "ami-044415bb13eee2391"
  instance_type               = "t2.micro"
  key_name                    = "pem"
  subnet_id                   = aws_subnet.public1.id
  security_groups             = [aws_security_group.allow_ssh_http.id]
  associate_public_ip_address = true

}
