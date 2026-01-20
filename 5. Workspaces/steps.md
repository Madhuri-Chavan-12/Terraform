### 1. Create Workspace:

    terraform workspace new dev  
    terraform workspace new stage   
    terraform workspace new prod  

### 2. Switch in workspace

	terraform workspace select dev

### 3. To see current workspace  

  	terraform workspace show

### 4.  init
    terrafrom init
### 5. Plan
    terraform plan -var-file=dev.tfvars

### 6. apply
    terraform apply -var-file=dev.tfvars 

### 7. destroy

    terraform destroy -var-file=dev.tfvars
