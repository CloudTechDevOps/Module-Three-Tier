

# -----------------------
# Frontend AMI
# -----------------------
data "aws_ami" "frontend" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = [var.frontend_ami]
  }
}

# -----------------------
# Backend AMI
# -----------------------
data "aws_ami" "backend" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = [var.backend_ami]
  }
}

# -----------------------
# Frontend Launch Template
# -----------------------
resource "aws_launch_template" "frontend" {
  name                   = "${var.project_name}-frontend-lt"
  description            = "Frontend launch template"
  image_id               = data.aws_ami.frontend.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.frontend_sg_id]
  key_name               = var.key_name
  update_default_version = true

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-frontend"
    }
  }
}

# -----------------------
# Backend Launch Template
# -----------------------
resource "aws_launch_template" "backend" {
  name                   = "${var.project_name}-backend-lt"
  description            = "Backend launch template"
  image_id               = data.aws_ami.backend.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.backend_sg_id]
  key_name               = var.key_name
  update_default_version = true

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-backend"
    }
  }
}
