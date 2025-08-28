variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "three-tier"
}

variable "identifier" {
  description = "Unique RDS identifier"
  type        = string
}

variable "allocated_storage" {
  description = "Storage size in GB"
  type        = number
  default     = 20
}

variable "engine" {
  description = "Database engine (e.g., mysql, postgres)"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Engine version"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "db_name" {
  description = "Initial database name"
  type        = string
}

variable "db_username" {
  description = "Master DB username"
  type        = string
}

variable "db_password" {
  description = "Master DB password"
  type        = string
  sensitive   = true
}

variable "db_subnet_1_id" {
  description = "First DB subnet ID"
  type        = string
}

variable "db_subnet_2_id" {
  description = "Second DB subnet ID"
  type        = string
}

variable "rds_sg_id" {
  description = "Security group ID for RDS"
  type        = string
}
