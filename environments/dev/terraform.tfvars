environment = "dev"
region      = "us-east-1"

# Networking
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
azs                  = ["us-east-1a", "us-east-1b"]

# Compute
instance_type   = "t3.micro"
min_size        = 1
max_size        = 3
desired_capacity= 1
scale_up_cpu_threshold   = 70
scale_down_cpu_threshold = 30

# Database
db_name                 = "devdb"
db_username             = "admin"
db_instance_class       = "db.t3.micro"
db_allocated_storage    = 20
db_multi_az             = false
db_backup_retention_days= 3

alert_emails = ["uketuianthony@gmail.com"]

