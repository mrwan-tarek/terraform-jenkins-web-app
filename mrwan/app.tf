resource "aws_lb" "app-lb" {
  name = "app-lb"
  internal     = true
  load_balancer_type = "application"
  security_groups = [ var.lb_sg ] 
  subnets =[ var.subnet_3 , var.subnet_4 ] 
}
resource "aws_lb_listener" "app-listener" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-tg.arn
  }
}
resource "aws_lb_target_group" "app-tg" {
  name     = "app-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_1
  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 2
    timeout = 5
    interval = 30
    protocol            = "HTTP"
    port                = "traffic-port"
  }
}


resource "aws_launch_configuration" "app_launch_config" {
  name_prefix = "app-server"
  image_id = var.ami
  instance_type = var.instance_type
  key_name = var.key_pair
  security_groups = [ var.lb_sg ]
  associate_public_ip_address = false
  user_data = "${file("app-server.sh")}"
    lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app_asg" {
  name = "app-server-asg"
  min_size             = var.min_size
  desired_capacity     = var.desired_size
  max_size             = var.max_size
  
  health_check_type    = "ELB"
  launch_configuration = aws_launch_configuration.app_launch_config.id
  vpc_zone_identifier  = [ var.subnet_3 , var.subnet_4 ]
  # Required to redeploy without an outage.

  tag {
    key                 = "Name"
    value               = "app"
    propagate_at_launch = true
  }
}
# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "app_attach" {
  autoscaling_group_name = aws_autoscaling_group.app_asg.id
  lb_target_group_arn    = aws_lb_target_group.app-tg.arn
}

resource "aws_autoscaling_policy" "target_tracking_app" {
  name                   = "target-tracking"
  scaling_adjustment     = 0
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
  estimated_instance_warmup = 300

  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    target_value = 50.0  # Target CPU utilization percentage
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
}
