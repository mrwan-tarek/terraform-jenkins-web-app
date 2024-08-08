output "autoscaling_group_name" {
  value = aws_lb.web-lb.dns_name
}