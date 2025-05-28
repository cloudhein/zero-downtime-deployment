output "frontend_server_address" {
  description = "frontend server url address"
  value       = "http://${aws_lb.frontend-lb.dns_name}"
  sensitive   = false
}