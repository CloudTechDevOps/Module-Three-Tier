variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

# Public Subnets
variable "public_subnet_1_cidr" { type = string }
variable "public_subnet_2_cidr" { type = string }

# Private Web Subnets
variable "private_subnet_1_cidr" { type = string }
variable "private_subnet_2_cidr" { type = string }

# Private App Subnets
variable "private_subnet_3_cidr" { type = string }
variable "private_subnet_4_cidr" { type = string }

# Private Database Subnets
variable "private_subnet_5_cidr" { type = string }
variable "private_subnet_6_cidr" { type = string }

# AZs
variable "availability_zone_1a" { type = string }
variable "availability_zone_1b" { type = string }




variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}
variable "allowed_ssh_cidr" {
  description = "CIDR block allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
