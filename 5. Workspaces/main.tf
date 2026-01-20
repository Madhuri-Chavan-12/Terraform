locals {
  environment = terraform.workspace
}

module "ec2" {
  source = "./modules/ec2"

  instance_type = var.instance_type_map[local.environment]
  os_type       = var.os_map[local.environment]

  name        = "${local.environment}-ec2"
  environment = local.environment
}

variable "instance_type_map" {
  type = map(string)
}

variable "os_map" {
  type = map(string)
}
