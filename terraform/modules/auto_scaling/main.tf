# AWS AutoScaling Group

resource "aws_autoscaling_group" "main" {
  name = "${var.env}-autoscaling-main"

  max_size = var.autoScaling_configuration.max_size
  min_size = var.autoScaling_configuration.min_size

  launch_template {
    id      = var.launch_template_id
    version = var.template_lasted_version
  }

  target_group_arns = var.tg_arn

  health_check_type = "ELB"

  health_check_grace_period = 600

  vpc_zone_identifier = var.subnet_ids

}

# AWS autoscaling policy

resource "aws_autoscaling_policy" "cpu_target" {
  name                   = "cpu-target-tracking"
  autoscaling_group_name = aws_autoscaling_group.main.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50.0
  }
}
