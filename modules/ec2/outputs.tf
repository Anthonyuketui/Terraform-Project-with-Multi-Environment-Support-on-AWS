output "asg_name" { value = aws_autoscaling_group.app.name }
output "ec2_sg_id" { value = aws_security_group.ec2_sg.id }

output "scale_up_policy_arn" {
  value = aws_autoscaling_policy.scale_up.arn
}

output "scale_down_policy_arn" {
  value = aws_autoscaling_policy.scale_down.arn
}
