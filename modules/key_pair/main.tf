resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh
}

resource "null_resource" "save_key" {
  provisioner "local-exec" {
    command = <<EOT
      echo '${tls_private_key.this.private_key_pem}' > ${var.private_key_output_path}
      chmod 400 ${var.private_key_output_path}
    EOT

  }

  triggers = {
    key_hash = tls_private_key.this.private_key_pem
  }
}






