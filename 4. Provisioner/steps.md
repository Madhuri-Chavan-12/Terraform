## 1. Create main.tf
### main.tf
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# -------------------------
# AMI (Latest Ubuntu 22.04)
# -------------------------
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# -------------------------
# VPC
# -------------------------
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "terraform-vpc"
  }
}

# -------------------------
# Subnet (public)
# -------------------------
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

# -------------------------
# Internet Gateway
# -------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# -------------------------
# Route Table
# -------------------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

# -------------------------
# Security Group
# -------------------------
resource "aws_security_group" "hello_sg" {
  name   = "hello-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ?? demo only
  }

  ingress {
    description = "Flask app"
    from_port   = 8080
    to_port     = 8080
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
    Name = "hello-sg"
  }
}

# -------------------------
# EC2 Instance
# -------------------------
resource "aws_instance" "python_hello" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.hello_sg.id]
  key_name               = "key_name"

  tags = {
    Name = "terraform-python-hello"
  }

  # SSH connection for provisioners
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key_name_path.pem")
    host        = self.public_ip
    timeout     = "5m"
  }

  # Copy app.py
  provisioner "file" {
    source      = "app.py"
    destination = "/home/ubuntu/app.py"
  }

  # Run Flask app
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y python3-pip",
      "sudo pip3 install flask",
      "nohup python3 /home/ubuntu/app.py > app.log 2>&1 &"
    ]
  }
}
```
## 2.
```
aws sts get-caller-identity
aws configure
```

### app.py 
```
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello, Terraform!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
```

## 3.
```
terraform init

terraform validate

terraform plan

terraform apply

```

## 4. AWS console -> EC2 -> Instances -> Copy Public IPv4

## 5. Browser test
```
http://<EC2_PUBLIC_IP>:8080
```
**Expected o/p:
Hello, Terraform!**


