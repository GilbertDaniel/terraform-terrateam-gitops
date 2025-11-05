# VPC
resource "aws_vpc" "main" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true

    tags = {
        Name = "main-vpc"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "main-igw"
    }
}

# Subnet
resource "aws_subnet" "main" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.1.0/24"
    availability_zone       = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true

    tags = {
        Name = "main-subnet"
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
        Name = "main-rt"
    }
}

resource "aws_route_table_association" "main" {
    subnet_id      = aws_subnet.main.id
    route_table_id = aws_route_table.main.id
}

# Security Group
resource "aws_security_group" "main" {
    name        = "main-sg"
    description = "Main security group"
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
        Name = "main-sg"
    }
}

# EC2 Instance
resource "aws_instance" "main" {
    ami                    = "ami-0609186b60570e9c9"
    instance_type          = "t3.micro"
    subnet_id              = aws_subnet.main.id
    vpc_security_group_ids = [aws_security_group.main.id]

    root_block_device {
        volume_size = 30
        volume_type = "gp3"
    }

    tags = {
        Name = "main-ec2"
    }
}

# Elastic IP
resource "aws_eip" "main" {
    instance = aws_instance.main.id
    domain   = "vpc"

    tags = {
        Name = "main-eip"
    }
}

# Data source for AZ
data "aws_availability_zones" "available" {
    state = "available"
}