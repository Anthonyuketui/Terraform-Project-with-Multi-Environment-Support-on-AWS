package terraform.aws.autoscaling

deny[msg] {
  input.resource_type == "aws_autoscaling_group"
  input.min_size < 1
  msg = sprintf("AutoScaling group %v must have min_size >= 1", [input.name])
}

deny[msg] {
  input.resource_type == "aws_autoscaling_group"
  input.max_size > 3
  msg = sprintf("AutoScaling group %v must have max_size <= 3", [input.name])
}

deny[msg] {
  input.resource_type == "aws_autoscaling_policy"
  input.scale_up_cpu_threshold > 80
  msg = "Scale-up CPU threshold should not exceed 80%"
}

deny[msg] {
  input.resource_type == "aws_autoscaling_policy"
  input.scale_down_cpu_threshold < 20
  msg = "Scale-down CPU threshold should not be below 20%"
}
