output "vpc_id" { value = module.vpc.vpc_id }
output "public_subnets" { value = module.vpc.public_subnets }
output "private_subnets" { value = module.vpc.private_subnets }

output "alb_dns_name" { value = module.alb.alb_dns_name }
output "asg_name" { value = module.ec2.asg_name }
output "ec2_sg_id" { value = module.ec2.ec2_sg_id }
output "db_endpoint" { value = module.rds.db_endpoint }
