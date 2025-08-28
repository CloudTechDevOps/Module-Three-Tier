variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "VPC ID for the ALB"
  type        = string
}

variable "subnets" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the ALB"
  type        = string
}

variable "alb_name" {
  description = "Name of the ALB"
  type        = string
  default     = "frontend-alb"
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
  default     = "frontend-tg"
}
