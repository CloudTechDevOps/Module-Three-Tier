output "frontend_launch_template_id" {
  value = aws_launch_template.frontend.id
}

output "backend_launch_template_id" {
  value = aws_launch_template.backend.id
}

output "frontend_launch_template_name" {
  value = aws_launch_template.frontend.name
}

output "backend_launch_template_name" {
  value = aws_launch_template.backend.name
}
