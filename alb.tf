resource "aws_lb_target_group" "aws_cloud2_tg" {
  name     = "aws-loud2-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.aws_cloud2.id
}


resource "aws_lb" "aws_cloud2_lb" {
  name               = "aws-cloud2-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.aws_cloud2_lb.id]
  subnets = [
    aws_subnet.my_public1.id,
    aws_subnet.my_public2.id,
  ]

  enable_deletion_protection = false


  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "aws_cloud2_listener" {
  load_balancer_arn = aws_lb.aws_cloud2_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws_cloud2_tg.arn
  }
}