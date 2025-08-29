terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.10.0"
    }
  }
}

provider "aws" {
  region = var.region
}
# Use latest Amazon Linux 2 AMI
data "aws_ami" "al2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


module "vpc" {
  source               = "../../modules/vpc"
  env                  = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}

module "alb" {
  source         = "../../modules/alb"
  env            = var.environment
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
}


locals {
  user_data = templatefile("${path.module}/user_data.sh.tmpl", {
    environment = var.environment
  })
}


module "ec2" {
  source           = "../../modules/ec2"
  env              = var.environment
  vpc_id           = module.vpc.vpc_id
  private_subnets  = module.vpc.private_subnets
  alb_sg_id        = module.alb.alb_sg_id
  target_group_arn = module.alb.target_group_arn

  ami_id          = data.aws_ami.al2.id
  instance_type   = var.instance_type

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  user_data       = local.user_data
}

module "rds" {
  source                  = "../../modules/rds"
  env                     = var.environment
  vpc_id                  = module.vpc.vpc_id
  private_subnets         = module.vpc.private_subnets
  ec2_sg_id               = module.ec2.ec2_sg_id
  db_name                 = var.db_name
  db_username             = var.db_username
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  multi_az                = var.db_multi_az
  backup_retention_days   = var.db_backup_retention_days
  maintenance_window      = var.db_maintenance_window
  backup_window           = var.db_backup_window
  deletion_protection     = var.db_deletion_protection
  skip_final_snapshot     = var.db_skip_final_snapshot
}

module "monitoring" {
  source = "../../modules/monitoring"

  env         = var.environment
  asg_name    = module.ec2.asg_name
  rds_instance_id = module.rds.db_identifier
  scale_up_cpu_threshold   = var.scale_up_cpu_threshold
  scale_down_cpu_threshold = var.scale_down_cpu_threshold

  # Pass scaling policy ARNs
  scale_up_policy_arn   = module.ec2.scale_up_policy_arn
  scale_down_policy_arn = module.ec2.scale_down_policy_arn

  # Optional ALB metrics (only if your alb module exports these)
  alb_arn_suffix          = try(module.alb.alb_arn_suffix, "")
  target_group_arn_suffix = try(module.alb.target_group_arn_suffix, "")

  # Alerts
  sns_topic_name = "${var.environment}-platform-alerts"
  alert_emails   = var.alert_emails
}
