terraform {
  backend "s3" {
    bucket         = "tf-state-576366844230-ap-south-1"
    key            = "global/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
