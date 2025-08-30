variable "env" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "sns_topic_name" {
  description = "Optional custom SNS topic name (defaults to <env>-platform-alerts if null)"
  type        = string
  default     = null
}

variable "alert_emails" {
  description = "List of email addresses subscribed to SNS alerts"
  type        = list(string)
  default     = []
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group to monitor"
  type        = string
}

variable "rds_instance_id" {
  description = "RDS instance identifier (e.g., dev-db)"
  type        = string
}

variable "alb_arn_suffix" {
  description = "ARN suffix of the ALB (from aws_lb.arn_suffix)"
  type        = string
  default     = ""
}

variable "target_group_arn_suffix" {
  description = "ARN suffix of the ALB target group (from aws_lb_target_group.arn_suffix)"
  type        = string
  default     = ""
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

variable "scale_up_policy_arn" {
  description = "ARN of the scale-up policy for the ASG"
  type        = string
}

variable "scale_down_policy_arn" {
  description = "ARN of the scale-down policy for the ASG"
  type        = string
}