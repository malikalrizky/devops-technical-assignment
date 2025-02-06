#---------------------------------------------------------
# Create Basic VPC and Subnet
#---------------------------------------------------------
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "vpc_private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_private_subnet
}

# Security Group
resource "aws_security_group" "main" {
  name        = "security_group"
  description = "security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

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
}

# ---------------------------------------------------------
# Create EC2 using module - Ideally the VPC and other
# components should use the same approach
# ---------------------------------------------------------
resource "aws_network_interface" "main" {
  subnet_id   = aws_subnet.vpc_private_subnet.id
  private_ips = ["10.0.1.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "main" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.main.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }
}