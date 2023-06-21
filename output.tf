output "alb_public_ips" {
  description = "ALB public access by using DNS"
  value       = aws_lb.aws_cloud2_lb.dns_name
}