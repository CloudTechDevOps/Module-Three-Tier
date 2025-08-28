variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "three-tier"
}

# Frontend ASG
variable "frontend_launch_template_id" {
  description = "Launch template ID for frontend"
  type        = string
}

variable "web_subnet_1_id" {
  description = "Frontend subnet 1"
  type        = string
}

variable "web_subnet_2_id" {
  description = "Frontend subnet 2"
  type        = string
}

variable "frontend_target_group_arn" {
  description = "Frontend ALB Target Group ARN"
  type        = string
}

variable "frontend_desired_capacity" {
  type    = number
  default = 1
}

variable "frontend_min_size" {
  type    = number
  default = 1
}

variable "frontend_max_size" {
  type    = number
  default = 3
}

# Backend ASG
variable "backend_launch_template_id" {
  description = "Launch template ID for backend"
  type        = string
}

variable "app_subnet_1_id" {
  description = "Backend subnet 1"
  type        = string
}

variable "app_subnet_2_id" {
  description = "Backend subnet 2"
  type        = string
}

variable "backend_target_group_arn" {
  description = "Backend ALB Target Group ARN"
  type        = string
}

variable "backend_desired_capacity" {
  type    = number
  default = 1
}

variable "backend_min_size" {
  type    = number
  default = 1
}

variable "backend_max_size" {
  type    = number
  default = 3
}

# Scaling Config
variable "scale_out_target_value" {
  description = "Target CPU utilization % for scaling"
  type        = number
  default     = 80
}
