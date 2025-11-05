variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "ap-southeast-1"
}

# Naming variables
variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
  default     = "terrateam-vpc"
}

variable "igw_name" {
  description = "Name for the Internet Gateway"
  type        = string
  default     = "terrateam-igw"
}

variable "subnet_name" {
  description = "Name for the Subnet"
  type        = string
  default     = "terrateam-subnet"
}

variable "route_table_name" {
  description = "Name for the Route Table"
  type        = string
  default     = "terrateam-rt"
}

variable "security_group_name" {
  description = "Name for the Security Group"
  type        = string
  default     = "terrateam-sg"
}

variable "ec2_name" {
  description = "Name for the EC2 Instance"
  type        = string
  default     = "terrateam-ec2"
}

variable "eip_name" {
  description = "Name for the Elastic IP"
  type        = string
  default     = "terrateam-eip"
}

# Configuration variables
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-0609186b60570e9c9"
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 30
}

variable "root_volume_type" {
  description = "Type of the root volume"
  type        = string
  default     = "gp3"
}

variable "security_group_description" {
  description = "Description for the security group"
  type        = string
  default     = "Main security group"
}