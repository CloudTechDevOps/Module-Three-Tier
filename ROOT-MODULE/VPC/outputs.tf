output "vpc_id" {
  value = aws_vpc.three_tier.id
}

output "public_subnets" {
  value = [aws_subnet.pub1.id, aws_subnet.pub2.id]
}

output "private_web_subnets" {
  value = [aws_subnet.prvt3.id, aws_subnet.prvt4.id]
}

output "private_app_subnets" {
  value = [aws_subnet.prvt5.id, aws_subnet.prvt6.id]
}

output "private_db_subnets" {
  value = [aws_subnet.prvt7.id, aws_subnet.prvt8.id]
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}


output "bastion_sg_id" {
  description = "ID of the Bastion Host SG"
  value       = aws_security_group.bastion_host.id
}

output "alb_frontend_sg_id" {
  description = "ID of the Frontend ALB SG"
  value       = aws_security_group.alb_frontend.id
}

output "alb_backend_sg_id" {
  description = "ID of the Backend ALB SG"
  value       = aws_security_group.alb_backend.id
}

output "frontend_server_sg_id" {
  description = "ID of the Frontend Server SG"
  value       = aws_security_group.frontend_server.id
}

output "backend_server_sg_id" {
  description = "ID of the Backend Server SG"
  value       = aws_security_group.backend_server.id
}

output "database_sg_id" {
  description = "ID of the Database SG"
  value       = aws_security_group.database.id
}
