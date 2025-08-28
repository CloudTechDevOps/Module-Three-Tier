provider "aws" {
  region = var.aws_region
  
}
resource "aws_instance" "bastionhost" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = "bastion-host"
  }
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "" 
  
}
variable "ami" {
  description = "AMI ID for the bastion host"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the bastion host"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet ID where the bastion will be launched"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the bastion host"
  type        = string
}

# variable "vpc_name" {
#   description = "Name prefix for tagging"
#   type        = string
# }

# variable "vpc_id" {
#   description = "VPC ID where security groups will be created"
#   type        = string
# }


output "bastion_instance_id" {
  value = aws_instance.bastionhost.id
}

output "bastion_public_ip" {
  value = aws_instance.bastionhost.public_ip
}

output "bastion_private_ip" {
  value = aws_instance.bastionhost.private_ip
}
