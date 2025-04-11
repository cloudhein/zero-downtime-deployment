output "backend_server_address" {
  description = "backend server url address"
  value       = "http://${aws_lb.app-lb.dns_name}:3000/api/v1/hello"
  sensitive   = false
}

output "backend_lb_dns_name" {
  description = "The DNS name of the backend load balancer"
  value       = aws_lb.app-lb.dns_name
}