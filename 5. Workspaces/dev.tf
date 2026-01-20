# for workspace varibales (similarly create for stage and prod region)

  instance_type_map = {
  dev   = "t3.micro"
  stage = "t3.small"
  prod  = "t3.large"
}

os_map = {
  dev   = "linux"
  stage = "ubuntu"
  prod  = "windows"
}

name = {
  dev   = "dev_ec2"
  stage = "stage_ec2"
  prod  = "prod_ec2"
}

envirnoment = {
  dev   = "dev"
  stage = "stage"
  prod  = "prod"
}
