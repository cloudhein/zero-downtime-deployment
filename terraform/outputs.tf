output "frontend_server_address" {
  description = "frontend server url address"
  value       = "http://${aws_lb.app-lb.dns_name}"
  sensitive   = false
}

output "backend_server_address" {
  description = "backend server url address"
  value       = "http://${aws_lb.app-lb.dns_name}:3000/api/v1/hello"
  sensitive   = false
}
