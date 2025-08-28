# ----------------- VPC -----------------
resource "aws_vpc" "three_tier" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

# ----------------- Public Subnets -----------------
resource "aws_subnet" "pub1" {
  vpc_id                  = aws_vpc.three_tier.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.availability_zone_1a
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-subnet-1"
  }
}

resource "aws_subnet" "pub2" {
  vpc_id                  = aws_vpc.three_tier.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = var.availability_zone_1b
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-subnet-2"
  }
}

# ----------------- Private Web Subnets -----------------
resource "aws_subnet" "prvt3" {
  vpc_id            = aws_vpc.three_tier.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.availability_zone_1a

  tags = {
    Name = "${var.vpc_name}-private-web-1"
  }
}

resource "aws_subnet" "prvt4" {
  vpc_id            = aws_vpc.three_tier.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.availability_zone_1b

  tags = {
    Name = "${var.vpc_name}-private-web-2"
  }
}

# ----------------- Private App Subnets -----------------
resource "aws_subnet" "prvt5" {
  vpc_id            = aws_vpc.three_tier.id
  cidr_block        = var.private_subnet_3_cidr
  availability_zone = var.availability_zone_1a

  tags = {
    Name = "${var.vpc_name}-private-app-1"
  }
}

resource "aws_subnet" "prvt6" {
  vpc_id            = aws_vpc.three_tier.id
  cidr_block        = var.private_subnet_4_cidr
  availability_zone = var.availability_zone_1b

  tags = {
    Name = "${var.vpc_name}-private-app-2"
  }
}

# ----------------- Private DB Subnets -----------------
resource "aws_subnet" "prvt7" {
  vpc_id            = aws_vpc.three_tier.id
  cidr_block        = var.private_subnet_5_cidr
  availability_zone = var.availability_zone_1a

  tags = {
    Name = "${var.vpc_name}-private-db-1"
  }
}

resource "aws_subnet" "prvt8" {
  vpc_id            = aws_vpc.three_tier.id
  cidr_block        = var.private_subnet_6_cidr
  availability_zone = var.availability_zone_1b

  tags = {
    Name = "${var.vpc_name}-private-db-2"
  }
}

# ----------------- Internet Gateway -----------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.three_tier.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# ----------------- Public Route Table -----------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.three_tier.id

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  for_each = {
    pub1 = aws_subnet.pub1.id
    pub2 = aws_subnet.pub2.id
  }

  subnet_id      = each.value
  route_table_id = aws_route_table.public_rt.id
}

# ----------------- NAT Gateway -----------------
resource "aws_eip" "nat_eip" {}

resource "aws_nat_gateway" "nat" {
  subnet_id         = aws_subnet.pub1.id
  allocation_id     = aws_eip.nat_eip.id
  connectivity_type = "public"

  tags = {
    Name = "${var.vpc_name}-nat"
  }
}

# ----------------- Private Route Table -----------------
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.three_tier.id

  tags = {
    Name = "${var.vpc_name}-private-rt"
  }

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "private" {
  for_each = {
    web-1      = aws_subnet.prvt3.id
    web-2      = aws_subnet.prvt4.id
    app-1      = aws_subnet.prvt5.id
    app-2      = aws_subnet.prvt6.id
    database-1 = aws_subnet.prvt7.id
    database-2 = aws_subnet.prvt8.id
  }

  subnet_id      = each.value
  route_table_id = aws_route_table.private_rt.id
}
