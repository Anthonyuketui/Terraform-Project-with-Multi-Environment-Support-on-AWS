resource "random_id" "secret_suffix" {
  byte_length = 4
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.env}-db-subnet"
  subnet_ids = var.private_subnets
  tags       = { Name = "${var.env}-db-subnet", Environment = var.env }
}

resource "aws_security_group" "db_sg" {
  name        = "${var.env}-db-sg"
  description = "Allow MySQL from app SG"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MySQL from EC2 SG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ec2_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.env}-db-sg", Environment = var.env }
}

resource "random_password" "db_password" {
  length           = 16
  override_special = "!#$%&*()-_=+"  # Only RDS-safe special characters
  upper            = true             # Include uppercase letters
  lower            = true             # Include lowercase letters
  numeric           = true             # Include numbers
  special          = true             # Enable special characters
}


resource "aws_secretsmanager_secret" "db_pwd" {
  name = "${var.env}/db_password-${random_id.secret_suffix.hex}"
}

resource "aws_secretsmanager_secret_version" "db_pwd_value" {
  secret_id     = aws_secretsmanager_secret.db_pwd.id
  secret_string = jsonencode({ password = random_password.db_password.result })
}

resource "aws_db_instance" "this" {
  identifier                 = "${var.env}-mysql"
  engine                     = "mysql"
  engine_version             = var.engine_version
  instance_class             = var.instance_class
  allocated_storage          = var.allocated_storage
  storage_type               = "gp2"
  username                   = var.db_username
  db_name                    = var.db_name
  password                   = random_password.db_password.result   # ✅ Use random_password directly
  multi_az                   = var.multi_az
  backup_retention_period    = var.backup_retention_days
  maintenance_window         = var.maintenance_window
  backup_window              = var.backup_window
  deletion_protection        = var.deletion_protection
  skip_final_snapshot        = var.skip_final_snapshot
  vpc_security_group_ids     = [aws_security_group.db_sg.id]
  db_subnet_group_name       = aws_db_subnet_group.this.name
  publicly_accessible        = false
  apply_immediately          = true
  auto_minor_version_upgrade = true
  tags = { Environment = var.env }
}
