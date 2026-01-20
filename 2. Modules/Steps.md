
## Terraform EC2 Module Implementation with Provider Inheritance and Dynamic AMI (No Hardcoding)

### Structure

```
module-ec2/
   |-- main.tf
   |-- provider.tf
   |--variables.tf
   |-- outputs.tf
   |-- terraform.tfvars
```


**main.tf**
```
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
```

**provider.tf**
```
provider "aws" {
region = var.region_type
}
```
**variables.tf**
```

variable "region_type" {
type = string
}


variable "instance_type" {
type = string
}

variable "instance_name" {
type = string
}

```

 **terraform.tfvars**
```
region_type = "ap-south-1"
instance_type = "t3.micro"
instance_name = "module-ec2-day-2"
```


**outputs.tf**
```

output "instance_id" {
value = aws_instance.this.id
}

output "public_ip" {
value = aws_instance.this.public_ip
}
```
---
**main.tf** (outside of module) 
```
module "ec2_instance" {
source = "./modules/ec2"
region_type = var.region_type
instance_type = var.instance_type
instance_name = var.instance_name
}
```
---
```
terraform init

terraform plan

terraform apply
 
terraform destroy
```
