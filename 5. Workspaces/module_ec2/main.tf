#################################
# AMI DATA SOURCES
#################################

# Amazon Linux 2
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Ubuntu 20.04
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

# Windows Server 2019
data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
}

#################################
# LOCALS - OS BASED AMI SELECTION
#################################

locals {
  ami_map = {
    linux   = data.aws_ami.amazon_linux.id
    ubuntu = data.aws_ami.ubuntu.id
    windows = data.aws_ami.windows.id
  }
}

#################################
# EC2 RESOURCE
#################################

resource "aws_instance" "this" {
  ami           = local.ami_map[var.os_type]
  instance_type = var.instance_type

  tags = {
    Name        = var.name
    Environment = var.environment
    OS          = var.os_type
  }
}
