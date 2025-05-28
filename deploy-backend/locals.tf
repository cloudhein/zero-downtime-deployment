locals {

  backend_instance_type = var.backend_instance_config.backend_instance_type
  backend_instance_name = var.backend_instance_config.backend_instance_name
  backend_environment   = var.backend_instance_config.backend_environment


  anywhere            = "0.0.0.0/0"
  ssh_port            = 22
  all_protocols_ports = "-1"
  tcp_protocol        = "tcp"
  icmp_protocol       = "icmp"
  backend_port        = 3000

  backendapp_port = 3000

}