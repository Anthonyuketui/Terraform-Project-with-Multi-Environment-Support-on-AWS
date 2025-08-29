output "db_endpoint" { value = aws_db_instance.this.endpoint }
output "db_sg_id" { value = aws_security_group.db_sg.id }
output "db_identifier" { value = aws_db_instance.this.id }
output "db_password_secret_arn" {
  value = aws_secretsmanager_secret.db_pwd.arn
}

output "db_password_secret_name" {
  value = aws_secretsmanager_secret.db_pwd.name
}

