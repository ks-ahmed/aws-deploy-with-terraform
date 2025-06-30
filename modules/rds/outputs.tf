output "db_endpoint" {
  value = aws_db_instance.rds.address
}

output "db_password" {
  value     = random_password.db.result
  sensitive = true
}
