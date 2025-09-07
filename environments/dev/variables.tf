# ========================
# Global / Environmentt
# ========================
variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
}


# ========================
# Networking
# ========================
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "azs" {
  description = "List of Availability Zones to use"
  type        = list(string)
}

# ========================
# Compute / Auto Scaling
# ========================
variable "instance_type" {
  description = "EC2 instance type for the ASG"
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "Minimum number of instances in ASG"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in ASG"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "Desired number of instances in ASG"
  type        = number
  default     = 1
}

variable "scale_up_cpu_threshold" {
  description = "CPU threshold (%) to trigger scale up"
  type        = number
  default     = 70
}

variable "scale_down_cpu_threshold" {
  description = "CPU threshold (%) to trigger scale down"
  type        = number
  default     = 30
}
variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "8.0"
}

variable "db_instance_class" {
  description = "Instance class for the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Allocated storage size (GB) for the RDS instance"
  type        = number
  default     = 20
}

variable "db_multi_az" {
  description = "Enable Multi-AZ deployment for RDS"
  type        = bool
  default     = false
}

variable "db_backup_retention_days" {
  description = "Number of days to retain backups"
  type        = number
  default     = 3
}

variable "db_maintenance_window" {
  description = "Preferred maintenance window for RDS"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "db_backup_window" {
  description = "Preferred backup window for RDS"
  type        = string
  default     = "03:00-06:00"
}

variable "db_deletion_protection" {
  description = "Enable deletion protection for the RDS instance"
  type        = bool
  default     = false
}

variable "db_skip_final_snapshot" {
  description = "Skip final snapshot on RDS deletion"
  type        = bool
  default     = true
}
variable "alert_emails" {
  description = "Email recipients for SNS alerts"
  type        = list(string)
  default     = []
}
