
# ─────────────────────────────
# VPC
# ─────────────────────────────
module "vpc" {
  source   = "../ROOT-MODULE/VPC"
aws_region = "us-east-1"
vpc_cidr = "10.0.0.0/16"
vpc_name = "prod-vpc"
public_subnet_1_cidr = "10.0.1.0/24"
public_subnet_2_cidr = "10.0.2.0/24"
private_subnet_1_cidr = "10.0.3.0/24"
private_subnet_2_cidr = "10.0.4.0/24"
private_subnet_3_cidr = "10.0.5.0/24"
private_subnet_4_cidr = "10.0.6.0/24"
private_subnet_5_cidr = "10.0.7.0/24"
private_subnet_6_cidr = "10.0.8.0/24"
availability_zone_1a = "us-east-1a"
availability_zone_1b = "us-east-1b"
vpc_id            = module.vpc.vpc_id
 allowed_ssh_cidr = ["0.0.0.0/0"]   
}

# ────────────────────────────
# AWS Bastion Host
# ─────────────────────────────
module "bastion" {
  source = "../ROOT-MODULE/BASTION"
aws_region = "us-east-1"
ami = "ami-00ca32bbc84273381"
instance_type = "t2.micro"
key_name = "us-east-1"
subnet_id = module.vpc.public_subnets[0]
security_group_id = module.vpc.bastion_sg_id

}

# ─────────────────────────────
# Frontend ALB
# ─────────────────────────────
module "frontend_alb" {
  source = "../ROOT-MODULE/LB-FRONTEND"
aws_region = "us-east-1"
vpc_id = module.vpc.vpc_id
subnets = module.vpc.public_subnets
security_group_id = module.vpc.alb_frontend_sg_id
alb_name = "frontend-alb"
target_group_name = "frontend-tg"

}

# ─────────────────────────────
# Backend ALB
# ─────────────────────────────
module "backend_alb" {
  source            = "../ROOT-MODULE/LB-BACKEND"
 aws_region = "us-east-1"
vpc_id = module.vpc.vpc_id
subnets = module.vpc.public_subnets
security_group_id = module.vpc.alb_backend_sg_id
alb_name = "backend-alb"
target_group_name = "backend-tg"
}

# ─────────────────────────────
# Frontend  and backend Launch Template
# ─────────────────────────────
module "frontend_and_backend_lt" {

  source        = "../ROOT-MODULE/LAUNCH-TEMPLATE"
  aws_region   = "us-east-1"
project_name   = "three-tier"
frontend_ami   = "frontend-ami"
backend_ami    = "backend-ami"
instance_type  = "t3.micro"
frontend_sg_id = module.vpc.frontend_server_sg_id
backend_sg_id  = module.vpc.backend_server_sg_id
key_name       = "us-east-1"

}

# ────────────────────────────
# Auto Scaling Group (App  and web Tier)
# ─────────────────────────────

module "asg" {
    source     = "../ROOT-MODULE/ASG"
aws_region = "us-east-1"
project_name = "books-three-tier"

# Frontend
frontend_launch_template_id = module.frontend_and_backend_lt.frontend_launch_template_id
web_subnet_1_id             = module.vpc.public_subnets[0]
web_subnet_2_id             = module.vpc.public_subnets[1]
frontend_target_group_arn   = module.backend_alb.alb_target_group_arn

frontend_desired_capacity = 1
frontend_min_size         = 1
frontend_max_size         = 3

# Backend
backend_launch_template_id = module.frontend_and_backend_lt.backend_launch_template_id
app_subnet_1_id            = module.vpc.private_app_subnets[0]
app_subnet_2_id            = module.vpc.private_app_subnets[1]
backend_target_group_arn   = module.frontend_alb.alb_target_group_arn
backend_desired_capacity = 1
backend_min_size         = 1
backend_max_size         = 3
# Scaling
scale_out_target_value = 80

}

# ─────────────────────────────
# RDS (DB Tier)
# ─────────────────────────────
module "rds" {
source         = "../ROOT-MODULE/RDS"
aws_region   = "us-east-1"
project_name = "three-tier"
identifier   = "book-rds"
allocated_storage = 20
engine            = "mysql"
engine_version    = "8.0"
instance_class    = "db.t3.micro"
multi_az          = false
db_name           = "bookdb"
db_username       = "admin"
db_password       = "SuperSecretPass123"
db_subnet_1_id    = module.vpc.private_db_subnets[0]
db_subnet_2_id    = module.vpc.private_db_subnets[1]
rds_sg_id         = module.vpc.database_sg_id

}