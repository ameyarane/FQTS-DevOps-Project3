resource "aws_lb" "this" {
  name               = "${var.company_name}-${var.lb_name}"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = var.security_groups

  tags = {
    Environment = var.env
    Project     = var.project_name
  }
}

resource "aws_lb_target_group" "this" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    interval            = 30
    path                = var.health_check_path
    protocol            = var.target_group_protocol
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

output "alb_dns_name" {
  value = aws_lb.this.dns_name
}



# ---------------------------
# LAUNCH TEMPLATE
# ---------------------------
resource "aws_launch_template" "lt" {
  name_prefix   = "${var.company_name}-${var.project_name}-${var.env}-lt"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups = var.security_groups
  }

  lifecycle {
    create_before_destroy = true
  }
}

# ---------------------------
# AUTO SCALING GROUP
# ---------------------------
resource "aws_autoscaling_group" "asg" {
  name                      = "${var.project_name}-${var.env}-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = var.asg_subnets
  health_check_type         = "EC2"

  target_group_arns         = [aws_lb_target_group.this.arn]

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
}

# ---------------------------
# OUTPUTS
# ---------------------------
output "asg_name" {
  value = aws_autoscaling_group.asg.name
}
