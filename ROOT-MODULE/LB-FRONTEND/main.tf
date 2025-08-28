resource "aws_lb_target_group" "front_end" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb" "front_end" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnets

  tags = {
    Name = var.alb_name
  }
  depends_on = [aws_lb_target_group.front_end]
}

resource "aws_lb_listener" "front_end_http" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
  depends_on = [aws_lb_target_group.front_end]
}

# resource "aws_lb_listener" "front_end_https" {
#   count             = var.certificate_arn != null ? 1 : 0
#   load_balancer_arn = aws_lb.front_end.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = var.certificate_arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.front_end.arn
#   }
#   depends_on = [aws_lb_target_group.front_end]
# }
