resource "aws_autoscaling_group" "spot" {
  count = length(var.spot_instance_types) > 0 && var.spot_desired_capacity > 0 ? 1 : 0

  name                      = "spot"
  capacity_rebalance        = true
  desired_capacity          = var.spot_desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  vpc_zone_identifier       = data.aws_subnets.default.ids
  health_check_grace_period = 180
  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 0
      spot_allocation_strategy                 = "lowest-price"
      spot_max_price                           = var.spot_max_price
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.base.id
        version            = aws_launch_template.base.latest_version
      }
      dynamic "override" {
        for_each = toset(var.spot_instance_types)
        content {
          instance_type = override.key
        }
      }
    }
  }
    tag {
      key = "Name"
      value = "spot"
      propagate_at_launch = true
  }
}