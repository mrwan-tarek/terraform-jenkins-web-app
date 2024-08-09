provider "aws" {
  region     = var.my-region
  access_key = var.my-access-key
  secret_key = var.my-secret-key
  token      = var.session-token
}

resource "aws_lb" "web-lb" {
  name = "web-lb"
  security_groups = [ aws_security_group.web-sg.id ] 
  subnets =[ aws_subnet.public_subnet_1.id , aws_subnet.public_subnet_2.id ] 
}
resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.web-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-tg.arn
  }
}
resource "aws_lb_target_group" "web-tg" {
  name     = "web-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
  }
}


resource "aws_launch_configuration" "web_launch_config" {
  name_prefix = "web-server"
  image_id = var.ami
  instance_type = var.instance_type
  key_name = var.key_pair
  security_groups = [ aws_security_group.web-sg.id ]
  associate_public_ip_address = true
  user_data = "${file("web-server.sh")}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web_asg" {
  name = "web-server-asg"
  min_size             = var.min_size
  desired_capacity     = var.desired_size
  max_size             = var.max_size
  
  health_check_type    = "ELB"
  launch_configuration = aws_launch_configuration.web_launch_config.id
  vpc_zone_identifier  = [ aws_subnet.public_subnet_1.id , aws_subnet.public_subnet_2.id ]
  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }
}
# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "web_attach" {
  autoscaling_group_name = aws_autoscaling_group.web_asg.id
  lb_target_group_arn    = aws_lb_target_group.web-tg.arn
}



resource "aws_autoscaling_policy" "target_tracking_web" {
  name                   = "target-tracking"
  scaling_adjustment     = 0
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
  estimated_instance_warmup = 300

  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    target_value = 50.0  # Target CPU utilization percentage
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
}
