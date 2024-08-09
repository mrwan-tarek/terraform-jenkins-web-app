output "web_autoscaling_group_name" {
  value = aws_lb.web-lb.dns_name
}
output "app_autoscaling_group_name" {
  value = aws_lb.app-lb.dns_name
}
output "RDS_endpoint" {
  value = aws_db_instance.rds.endpoint
}