
# data "aws_security_group" "rds_sg" {
#   filter {
#     name   = "tag:Name"
#     values = ["book-rds-sg"]
#   }
# }


# --------------------------
# RDS Subnet Group
# --------------------------
resource "aws_db_subnet_group" "rds-db-group" {
  name       = "${var.project_name}-rds-subnet-grp"
  subnet_ids = [var.db_subnet_1_id, var.db_subnet_2_id]

  tags = {
    Name = "${var.project_name}-rds-subnet-grp"
  }
}

# --------------------------
# RDS Instance
# --------------------------
resource "aws_db_instance" "book-rds" {
  identifier             = var.identifier
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  multi_az               = var.multi_az
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  vpc_security_group_ids = [var.rds_sg_id]
  publicly_accessible    = false
  backup_retention_period = 7
  db_subnet_group_name   = aws_db_subnet_group.rds-db-group.name

  tags = {
    Name = "${var.project_name}-rds"
  }
}
