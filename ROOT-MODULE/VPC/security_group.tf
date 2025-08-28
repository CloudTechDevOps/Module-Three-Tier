# Bastion Host SG
resource "aws_security_group" "bastion_host" {
  name        = "bastion-host-sg"
  description = "Allow SSH from allowed CIDRs"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-host-sg"
  }
}

# ALB Frontend SG
resource "aws_security_group" "alb_frontend" {
  name        = "alb-frontend-sg"
  description = "Allow HTTP/HTTPS from public"
  vpc_id      = var.vpc_id

  ingress = [
    for port in [80, 443] : {
      description      = "Allow HTTP/HTTPS"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-frontend-sg"
  }
}

# ALB Backend SG
resource "aws_security_group" "alb_backend" {
  name        = "alb-backend-sg"
  description = "Allow HTTP/HTTPS for backend"
  vpc_id      = var.vpc_id

  ingress = [
    for port in [80, 443] : {
      description      = "Allow HTTP/HTTPS"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-backend-sg"
  }
}

# Frontend Server SG
resource "aws_security_group" "frontend_server" {
  name        = "frontend-server-sg"
  description = "Allow SSH + HTTP for frontend servers"
  vpc_id      = var.vpc_id

  ingress = [
    for port in [22, 80] : {
      description      = "Allow SSH/HTTP"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "frontend-server-sg"
  }
}

# Backend Server SG
resource "aws_security_group" "backend_server" {
  name        = "backend-server-sg"
  description = "Allow SSH + HTTP for backend servers"
  vpc_id      = var.vpc_id

  ingress = [
    for port in [22, 80] : {
      description      = "Allow SSH/HTTP"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "backend-server-sg"
  }
}

# Database SG
resource "aws_security_group" "database" {
  name        = "database-sg"
  description = "Allow MySQL access"
  vpc_id      = var.vpc_id

  ingress {
    description = "MySQL/Aurora"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # (Better: restrict to backend SG only)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database-sg"
  }
}
