locals {

  frontend_instance_type = var.frontend_instance_config.frontend_instance_type
  frontend_instance_name = var.frontend_instance_config.frontend_instance_name
  frontend_environment   = var.frontend_instance_config.frontend_environment

  anywhere            = "0.0.0.0/0"
  ssh_port            = 22
  all_protocols_ports = "-1"
  tcp_protocol        = "tcp"
  icmp_protocol       = "icmp"
  http_port           = 80

  frontendapp_port = 80

}