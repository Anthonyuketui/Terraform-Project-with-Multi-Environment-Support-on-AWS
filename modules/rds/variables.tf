# ========================
# Environment & Networking
# ========================
variable "env" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where RDS will be deployed"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs for RDS"
  type        = list(string)
}

variable "ec2_sg_id" {
  description = "Security group ID for EC2 that needs DB access"
  type        = string
}

# ========================
# Database
# ========================
variable "db_name" {
  description = "Name of the initial database to create"
  type        = string
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
}


variable "engine_version" {
  description = "Database engine version (e.g., 8.0 for MySQL, 15.4 for PostgreSQL)"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "RDS instance class (e.g., db.t3.micro)"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated storage (in GB) for the database"
  type        = number
  default     = 20
}

variable "multi_az" {
  description = "Whether to enable Multi-AZ deployment for high availability"
  type        = bool
  default     = false
}

variable "backup_retention_days" {
  description = "Number of days to retain backups"
  type        = number
  default     = 3
}

variable "maintenance_window" {
  description = "Weekly time range for system maintenance (UTC)"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "backup_window" {
  description = "Daily time range during which automated backups are created (UTC)"
  type        = string
  default     = "03:00-06:00"
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection on the DB instance"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Whether to skip taking a final snapshot before DB deletion"
  type        = bool
  default     = true
}
