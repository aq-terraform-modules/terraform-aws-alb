resource "aws_lb" "core_lb" {
  name                       = "${var.name}"
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  security_groups            = var.security_groups
  subnets                    = var.subnets
  enable_deletion_protection = var.enable_deletion_protection
  ip_address_type            = var.ip_address_type

  dynamic "subnet_mapping" {
    for_each = var.subnet_mapping

    content {
      subnet_id            = subnet_mapping.value.subnet_id
      allocation_id        = lookup(subnet_mapping.value, "allocation_id", null)
      private_ipv4_address = lookup(subnet_mapping.value, "private_ipv4_address", null)
      ipv6_address         = lookup(subnet_mapping.value, "ipv6_address", null)
    }
  }
}

resource "aws_lb_target_group" "default_target_group" {
  name = "${var.name}-default"
  port = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = var.vpc_id
}

resource "aws_lb_listener" "HTTP" {
  load_balancer_arn = aws_lb.core_lb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.default_target_group.arn
  }
}