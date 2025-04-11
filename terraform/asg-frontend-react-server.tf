# Create a Security Group for frontend security group
resource "aws_security_group" "frontend_sg" {
  name        = "frontend_sg"
  description = "Allow frontendapp inbound and all outbound"
  vpc_id      = data.aws_vpc.default_vpc.id

  tags = {
    Name = "frontend_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_frontendapp_rules" {
  security_group_id = aws_security_group.frontend_sg.id

  cidr_ipv4   = local.anywhere
  from_port   = local.frontendapp_port
  ip_protocol = local.tcp_protocol
  to_port     = local.frontendapp_port
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_frontend" {
  security_group_id = aws_security_group.frontend_sg.id
  cidr_ipv4         = local.anywhere
  ip_protocol       = local.all_protocols_ports # semantically equivalent to all ports
}

# frontend launch template configuration
resource "aws_launch_template" "asg-frontend-app-template" {
  name          = "asg-frontend-app-template"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = local.frontend_instance_type

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.frontend_sg.id, aws_security_group.ssh_sg.id]
  }

  user_data = base64encode(templatefile("${path.module}/config/frontend.sh.tftpl", {
    backend_ip = aws_lb.app-lb.dns_name
  }))

  depends_on = [
    aws_autoscaling_group.asg-backend-app
  ]

  block_device_mappings {
    device_name = data.aws_ami.ubuntu.root_device_name # if ami root device name is not defined, your instance will attahced with 2 ebs volume

    ebs {
      volume_size = 20
      volume_type = "gp3"
    }
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ReactJS Frontend Instance"
    }
  }
}

# frontend autoscaling group
resource "aws_autoscaling_group" "asg-frontend-app" {
  name                      = "asg-frontend-app"
  vpc_zone_identifier       = data.aws_subnets.default_vpc_subnets.ids
  min_size                  = var.asg_frontend_min_size
  max_size                  = var.asg_frontend_max_size
  desired_capacity          = var.asg_frontend_desired_capacity
  force_delete              = true
  health_check_grace_period = 0 # zero downtime health check
  health_check_type         = "ELB"

  target_group_arns = [aws_lb_target_group.frontend_tg.arn]

  launch_template {
    id      = aws_launch_template.asg-frontend-app-template.id
    version = aws_launch_template.asg-frontend-app-template.latest_version
  }

  # zero downtime maintenance
  instance_maintenance_policy {
    min_healthy_percentage = 100
    max_healthy_percentage = 200
  }

  # Required if you want to automate rolling updates of new aws launch template
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 100
      max_healthy_percentage = 200
    }
  }


  tag {
    key                 = "Name"
    value               = "asg-frontend-app"
    propagate_at_launch = true
  }
  tag {
    key                 = "Environment"
    value               = "dev"
    propagate_at_launch = true
  }
}

# Attaches a load balancer to an Auto Scaling group
resource "aws_autoscaling_attachment" "asg-alb-attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg-frontend-app.id
  lb_target_group_arn    = aws_lb_target_group.frontend_tg.arn
}

# Scale out policy based on CPU utilization 
resource "aws_autoscaling_policy" "asg-scale-out" {
  name        = "asg-scale-out"
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.frontend_cpu_utilization_threshold_percentage
  }
  autoscaling_group_name = aws_autoscaling_group.asg-frontend-app.id
}


#resource "aws_instance" "frontend_server" {
#  count = var.create_instances ? var.instance_count : 0
#
#  ami           = data.aws_ami.ubuntu.id
#  instance_type = local.frontend_instance_type
#  vpc_security_group_ids = [
#    aws_security_group.frontend_sg.id,
#    aws_security_group.ssh_sg.id
#  ]
#  subnet_id = element(data.aws_subnets.default_vpc_subnets.ids, count.index) # create instances in different subnets
#
#  tags = {
#    Name        = "${local.frontend_instance_name}-${count.index + 1}"
#    Environment = local.frontend_environment
#  }
#
#  user_data = templatefile("${path.module}/config/frontend.sh.tftpl", {
#    backend_ip = aws_instance.backend_server[0].public_ip
#  })
#
#  user_data_replace_on_change = true
#
#  # Add this block for 20GB EBS storage
#  root_block_device {
#    volume_size = 20
#    volume_type = "gp3"
#  }
#
#  depends_on = [
#    aws_instance.backend_server[0]
#  ]
#}