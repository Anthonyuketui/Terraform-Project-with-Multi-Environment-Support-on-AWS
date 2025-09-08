package terraform.aws.rds

deny[msg] {
  input.resource_type == "aws_db_instance"
  input.db_instance_class != "db.t3.micro"
  msg = sprintf("DB instance %v must be db.t3.micro in dev", [input.name])
}

deny[msg] {
  input.resource_type == "aws_db_instance"
  input.db_multi_az == true
  msg = sprintf("DB instance %v should not be Multi-AZ in dev", [input.name])
}

deny[msg] {
  input.resource_type == "aws_db_instance"
  input.db_backup_retention_days < 3
  msg = sprintf("DB instance %v must have backup retention >= 3 days", [input.name])
}
