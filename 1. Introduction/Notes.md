# Terraform   
- Terraform is an Infrastructure as Code (IaC) tool used to provision and manage infrastructure using code instead of manual cloud console operations.

- It allows you to define infrastructure such as servers, networks, load balancers, and databases in declarative configuration files and manage them consistently across environments.

**Why Terraform is Important**

1. Terraform solves real production problems:

2. Infrastructure can be version-controlled (Git)

3. Same infrastructure can be recreated multiple times reliably

4. Eliminates human errors caused by manual console clicks

5. Enables collaboration across teams

6. Works with multiple cloud providers (AWS, Azure, GCP, etc.)

7. Manual infrastructure is fragile. Terraform makes it repeatable and predictable.
---

## Core Terraform Concepts

### 1. Provider

- A provider tells Terraform which platform or service it should interact with.

Examples:

1. AWS

2. Azure

3. Google Cloud

```
provider "aws" {
  region = "ap-south-1"
}
```



### 2. Resource

- A resource represents an actual infrastructure component.

Examples:

1. EC2 instance

2. S3 bucket

3. VPC

4. IAM role

```
resource "aws_instance" "web" {
  ami           = "ami-0abcdef"
  instance_type = "t2.micro"
}
```

- This creates an EC2 instance in AWS.

### 3. Terraform Files Structure

- Terraform configurations are written in .tf files.

Typical project structure:
```
main.tf        → resources
variables.tf   → input variables
outputs.tf     → output values
provider.tf    → provider configuration
terraform.tf   → backend & version settings
```

- Separating files improves readability and maintainability.


### 4. Terraform Workflow 

**1. Initialize**
```
terraform init
```

- Downloads providers

- Initializes backend

**2. Plan**  
```
terraform plan
```

- Shows what changes Terraform will make

**3. Apply**  
```
terraform apply
```

- Creates or updates infrastructure

**4. Destroy**
```
terraform destroy
```

- Deletes all managed infrastructure

**5. Terraform State**

- Terraform maintains a state file that tracks real infrastructure.

```
terraform.tfstate
```

- The state file stores:

1. What resources exist

2. Their current configuration

3. Dependencies between resources


**6. Terraform Modules**

- Modules allow code reusability and clean architecture.

Example module structure:
```
modules/ec2/
  └── main.tf
```

Usage:
```
module "web" {
  source = "./modules/ec2"
}
```

- Modules help avoid duplicate code and simplify large infrastructures.

**7. count** 
```
count = 2
```

- Index-based

- Risky when modifying resources

**8. for_each**  
```
for_each = toset(["web1", "web2"])
```

- Stable

- Easier to manage and scale
---
### Terraform vs Ansible

| Terraform	&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;  | Ansible  &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ensp;&ensp;&ensp;|  
|-------------------------------------------------------|----------------------------------------------------------------------------|
| Infrastructure provisioning   | Configuration management  &ensp; |  
| Declarative &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ensp;|	Procedural &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ensp; |  
| Maintains state &emsp;&emsp;&emsp;&emsp;&emsp; &ensp;|	Stateless &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;|  
| Cloud-focused	&emsp;&emsp;&emsp;&emsp;&emsp;&ensp;  | OS & app focused &emsp;&emsp;&emsp;&emsp; |  

- **Terraform creates infrastructure.**
- **Ansible configures infrastructure.**


