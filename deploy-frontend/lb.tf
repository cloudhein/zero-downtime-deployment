resource "aws_lb" "frontend-lb" {
  name               = "frontend-lb"
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.frontend-lb_sg.id]
  subnets            = data.aws_subnets.default_vpc_subnets.ids

  enable_deletion_protection = false

  tags = {
    Name        = "frontend-lb"
    Environment = "dev"
  }
}

# Frontend listener
resource "aws_lb_listener" "alb__frontend_listener" {
  load_balancer_arn = aws_lb.frontend-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}

# Frontend target group
resource "aws_lb_target_group" "frontend_tg" {
  name        = "frontend-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.default_vpc.id

  health_check {
    enabled  = true
    interval = 20 # healthy threshold interval
    path     = "/"
    port     = "80"
    #protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 15 # unhealthy threshold interval
    matcher             = "200"
  }

  deregistration_delay = 10

  tags = {
    Name = "frontend-target-group"
  }
}


# Create a Security Group for ALB
resource "aws_security_group" "frontend-lb_sg" {
  name        = "frontend-lb_sg"
  description = "Allow HTTP inbound and all outbound"
  vpc_id      = data.aws_vpc.default_vpc.id

  tags = {
    Name = "frontend-lb_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_rules" {
  security_group_id = aws_security_group.frontend-lb_sg.id

  cidr_ipv4   = local.anywhere
  from_port   = local.http_port
  ip_protocol = local.tcp_protocol
  to_port     = local.http_port
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_alb" {
  security_group_id = aws_security_group.frontend-lb_sg.id
  cidr_ipv4         = local.anywhere
  ip_protocol       = local.all_protocols_ports # semantically equivalent to all ports
}