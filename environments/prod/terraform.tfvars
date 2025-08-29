
environment = "prod"
region      = "us-east-1"


vpc_cidr             = "10.1.0.0/16"
public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnet_cidrs = ["10.1.11.0/24", "10.1.12.0/24"]
azs                  = ["us-east-1a", "us-east-1b"]


instance_type        = "t3.medium"
min_size             = 2
max_size             = 5
desired_capacity     = 2
scale_up_cpu_threshold   = 70
scale_down_cpu_threshold = 30


db_name                 = "proddb"
db_username             = "admin"
db_instance_class       = "db.t3.medium"
db_allocated_storage    = 50
db_multi_az             = true
db_backup_retention_days= 7


alert_emails = ["uketuianthony@gmail.com"]
