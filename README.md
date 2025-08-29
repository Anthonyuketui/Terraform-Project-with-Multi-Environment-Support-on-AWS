```markdown
# Production-Ready Terraform Project with Multi-Environment Support

This repository contains a **production-ready AWS infrastructure** setup using Terraform, designed to support multiple environments (`dev` and `prod`). The infrastructure is modular, secure, and scalable with monitoring and auto-scaling capabilities.

---

## Features

- **Multi-environment support**: Separate configurations for `dev` and `prod`.
- **Modular design**: Reusable Terraform modules for VPC, ALB, EC2, RDS, and monitoring.
- **Auto Scaling**: EC2 Auto Scaling Group adjusts capacity based on CPU utilization.
- **Application Load Balancer (ALB)**: Distributes traffic to private EC2 instances.
- **RDS Database**: Secure MySQL database with credentials stored in AWS Secrets Manager.
- **Monitoring & Alerts**: CloudWatch alarms with SNS email notifications for EC2, ALB, and RDS.
- **Secure networking**: Public and private subnets, security groups, and proper routing.

---

## Repository Structure

```

├── modules/
│   ├── vpc/
│   ├── alb/
│   ├── ec2/
│   ├── rds/
│   └── monitoring/
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   └── terraform.tfvars
│   └── prod/
│       ├── main.tf
│       └── terraform.tfvars
├── README.md
└── .gitignore

````

- **modules/**: Contains reusable Terraform modules.
- **environments/**: Environment-specific Terraform configurations.
- **main.tf / terraform.tfvars**: Deploy environment-specific infrastructure.

---

## Prerequisites

- [Terraform 1.5+](https://www.terraform.io/downloads)
- [AWS CLI](https://aws.amazon.com/cli/)
- An AWS account with sufficient IAM permissions to create:
  - VPC, Subnets, Route Tables
  - EC2, Security Groups, ALB
  - RDS, Secrets Manager
  - CloudWatch and SNS

---

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/terraform-multi-env.git
cd terraform-multi-env
````

### 2. Deploy the Dev Environment

```bash
cd environments/dev
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

### 3. Deploy the Prod Environment

```bash
cd ../prod
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

> Each environment is isolated and can be managed independently using its own `tfvars` file.

---

## Module Overview

### VPC Module

* Creates a VPC with public and private subnets.
* Configures Internet Gateway and NAT Gateway for outbound internet access.
* Ensures private subnets for EC2 and RDS instances.

### ALB Module

* Internet-facing Application Load Balancer in public subnets.
* Routes traffic to private EC2 instances.
* Configurable health checks.

### EC2 Module

* Launch Template + Auto Scaling Group.
* User-data script bootstraps HTTP server.
* CloudWatch metrics and alarms integrated.
* Supports scaling policies (scale up/down based on CPU).

### RDS Module

* MySQL database in private subnet.
* Secure credentials using AWS Secrets Manager.
* Configurable instance size per environment.

### Monitoring Module

* CloudWatch alarms for:

  * EC2 Auto Scaling CPU usage
  * RDS CPU and storage
  * Optional ALB target group health checks
* Alerts sent via SNS topic to configured emails.

---

## Environment Variables & `terraform.tfvars`

Example `dev/terraform.tfvars`:

```hcl
environment        = "dev"
region             = "us-east-1"
instance_type      = "t3.micro"
desired_capacity   = 1
db_instance_class  = "db.t3.micro"
alert_emails       = ["youremail@example.com"]
```

Example `prod/terraform.tfvars`:

```hcl
environment        = "prod"
region             = "us-east-1"
instance_type      = "t3.medium"
desired_capacity   = 2
db_instance_class  = "db.t3.medium"
alert_emails       = ["youremail@example.com"]
```

---

## Security Considerations

* **Private subnets** for EC2 and RDS.
* **Secrets Manager** used for storing database passwords.
* Security groups restrict access:

  * ALB allows HTTP from the internet.
  * EC2 allows HTTP only from ALB.

---

## Troubleshooting

* If Auto Scaling Group instances are **not registering as healthy**:

  * Check that ALB security group allows traffic to EC2.
  * Ensure the EC2 user-data script correctly sets up the app.

* For CloudWatch alarms:

  * Ensure the ASG name and scaling policy ARNs are passed to the monitoring module.

---

## Contributing

1. Fork the repository
2. Create a new branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -m "Add new feature"`
4. Push to your branch: `git push origin feature/my-feature`
5. Open a Pull Request

---

## License

This project is licensed under the MIT License.

```
