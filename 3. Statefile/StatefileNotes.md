# Terraform State File 

Terraform uses a state file (terraform.tfstate) to keep track of the real-world infrastructure it manages.
This file maps Terraform configuration to actual resources created in the cloud or on-prem systems.  

**State file is Terraform’s brain**


### **Why the State File is Important**

- Tracks resource IDs and metadata

- Enables terraform plan to calculate diffs

- Prevents duplicate resource creation

- Required for updates, deletes, and drift detection

**Without the state file, Terraform has no idea what it previously created.**



### **What the State File Contains**

- Resource mappings (Terraform → Provider resources)

- Dependency information

- Resource attributes (including sensitive data)

- Provider configuration details


**Never commit state files to Git repositories, especially public ones.**

##### Reasons:

- Contains sensitive data

- High risk of state corruption

- Causes conflicts in team environments

- Breaks collaboration



##### Use a remote backend instead of local state:


1. AWS S3 + DynamoDB (locking)

2. Azure Blob Storage

3. Google Cloud Storage

4. Terraform Cloud / Terraform Enterprise

##### Benefits:

1. Centralized state

2. State locking (prevents concurrent changes)

3. Better security

4. Team collaboration support
---
## **State Locking**

- State locking prevents multiple users from modifying infrastructure at the same time.

- Enabled automatically with most remote backends

- Critical for avoiding race conditions and corruption
---


## **Key Commands Related to State**

1. terraform state list

2. terraform state show <resource>

3. terraform state mv

4. terraform state rm
