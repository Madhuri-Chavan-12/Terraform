### Step 1: Create S3 and DynamoDB 

#### main.tf

```
provider "aws" {
  region = "ap-south-1"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "tf_state" {
  bucket = "tf-state-${data.aws_caller_identity.current.account_id}-ap-south-1"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
```
### Step 2: 
```
terraform init
```

### Step 3: 
```
terraform plan
```

### Step 4: 
```
terraform apply
```

### Step 5:  Add backend.tf

```
terraform {
  backend "s3" {
    bucket         = "tf-state-576366844230-ap-south-1"
    key            = "global/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
```

### Step 6: Reinitialize
```
terraform init -reconfigure
```

### Step 7: From terminal 1 (eg Engineer A) 
```
terraform apply
```
  7.1 From terminal 2 (eg Engineer B) 
  
```
terraform apply
```

- ### **Error:   acquiring the state lock**
