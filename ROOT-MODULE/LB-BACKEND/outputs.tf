output "alb_arn" {
  value = aws_lb.back_end.arn
}

output "alb_dns_name" {
  value = aws_lb.back_end.dns_name
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.back_end.arn
}
