output "alb_arn" {
  value = aws_lb.front_end.arn
}

output "alb_dns_name" {
  value = aws_lb.front_end.dns_name
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.front_end.arn
}
