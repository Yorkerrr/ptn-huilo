resource "aws_autoscaling_group" "on_demand" {
  count = var.on_demand_desired_capacity > 0 ? 1 : 0

  name                      = "on-demand"
  capacity_rebalance        = true
  desired_capacity          = var.on_demand_desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  vpc_zone_identifier       = data.aws_subnets.default.ids
  health_check_grace_period = 180
  launch_template {
    id      = aws_launch_template.base.id
    version = aws_launch_template.base.latest_version
  }

  tag {
      key = "Name"
      value = "on-demand"
      propagate_at_launch = true
  }
}