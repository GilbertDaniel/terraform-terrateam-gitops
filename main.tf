# VPC
resource "aws_vpc" "main" {
    cidr_block           = var.vpc_cidr_block
    enable_dns_hostnames = true
    enable_dns_support   = true

    tags = {
        Name = var.vpc_name
    }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = var.igw_name
    }
}

# Subnet
resource "aws_subnet" "main" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = var.subnet_cidr_block
    availability_zone       = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true

    tags = {
        Name = var.subnet_name
    }
}

# Route Table
resource "aws_route_table" "main" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }

    tags = {
        Name = var.route_table_name
    }
}

resource "aws_route_table_association" "main" {
    subnet_id      = aws_subnet.main.id
    route_table_id = aws_route_table.main.id
}

# Security Group SG
resource "aws_security_group" "main" {
    name        = var.security_group_name
    description = var.security_group_description
    vpc_id      = aws_vpc.main.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = var.security_group_name
    }
}

# EC2 Instance
resource "aws_instance" "main" {
    ami                    = var.ami_id
    instance_type          = var.instance_type
    subnet_id              = aws_subnet.main.id
    vpc_security_group_ids = [aws_security_group.main.id]

    root_block_device {
        volume_size = var.root_volume_size
        volume_type = var.root_volume_type
    }

    tags = {
        Name = var.ec2_name
    }
}

# Elastic IP
resource "aws_eip" "main" {
    instance = aws_instance.main.id
    domain   = "vpc"

    tags = {
        Name = var.eip_name
    }
}

# Data source for AZ
data "aws_availability_zones" "available" {
    state = "available"
}