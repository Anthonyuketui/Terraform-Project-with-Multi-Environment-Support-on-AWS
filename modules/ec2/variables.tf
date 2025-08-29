# ========================
# Environment
# ========================
variable "env" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}

# ========================
# Networking
# ========================
variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "alb_sg_id" {
  description = "Security group ID for the ALB"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the target group for ALB"
  type        = string
}

# ========================
# Compute
# ========================
variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "user_data" {
  description = "User data script to bootstrap EC2 instances"
  type        = string
}

variable "min_size" {
  description = "Minimum number of instances in Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in Auto Scaling Group"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of instances in Auto Scaling Group"
  type        = number
}

# ========================
# Auto Scaling Policies
# ========================
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
