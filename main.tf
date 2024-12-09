# Define the AWS provider
provider "aws" {
  region = "us-east-1" 
}

# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main_vpc"
  }
}

# Public Subnet in AZ 1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "public_subnet_az1"
  }
}

# Public Subnet in AZ 2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "public_subnet_az2"
  }
}

# Private Subnet in AZ 1
resource "aws_subnet" "private_subnet_az1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private_subnet_az1"
  }
}

# Private Subnet in AZ 2
resource "aws_subnet" "private_subnet_az2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.8.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private_subnet_az2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main_igw"
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rt"
  }
}

# Associate Route Table with Public Subnet AZ 1
resource "aws_route_table_association" "public_rt_association_az1" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public_rt.id
}

# Associate Route Table with Public Subnet AZ 2
resource "aws_route_table_association" "public_rt_association_az2" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Group for Web Application
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP traffic
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }

  tags = {
    Name = "web_sg"
  }
}

# EC2 Instance in Public Subnet AZ 1
resource "aws_instance" "web_app_instance" {
  ami                    = "ami-0453ec754f44f9a4a" # Amazon Linux 2023 AMI (free-tier eligible)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_az1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = "MyKeyPair" # Replace with your actual key pair name

  tags = {
    Name = "web_app_instance"
  }
}

# RDS Database in Private Subnet
resource "aws_db_instance" "db_instance" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0.34" 
  instance_class         = "db.t3.micro" 
  username               = "admin"
  password               = "password123" 
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name

  tags = {
    Name = "db_instance"
  }
}


# DB Subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [
    aws_subnet.private_subnet_az1.id,
    aws_subnet.private_subnet_az2.id, # Subnets in both Availability Zones
  ]

  tags = {
    Name = "db_subnet_group"
  }
}
