package terraform.aws.ec2

deny[msg] {
  input.resource_type == "aws_instance"
  input.instance_type != "t3.micro"
  msg = sprintf("EC2 instance %v must be t3.micro in dev", [input.name])
}
