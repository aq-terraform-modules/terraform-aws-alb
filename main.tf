resource "aws_security_group" "lb_sg" {
  name        = "${var.name}_lb_sg"
  description = "Security Group for Load Balancer"

  ingress = {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_lb" "core_lb" {
  name                       = "${var.name}_lb"
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  security_groups            = [aws_security_group.lb_sg.id]
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