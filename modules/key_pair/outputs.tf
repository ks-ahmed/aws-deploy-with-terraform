output "key_name" {
  description = "The name of the EC2 key pair"
  value       = aws_key_pair.this.key_name
}

output "private_key_pem" {
  description = "The generated private key"
  value       = tls_private_key.this.private_key_pem
  sensitive   = true
}
