provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "go-test-networking" {
  source                   = "../modules/go-test-networking"
  common_name              = "go-test"
  vpc_cidr                 = "192.168.0.0/16"
  public_subnet_cidr_list  = ["192.168.1.0/24"]
  private_subnet_cidr_list = ["192.168.2.0/24"]
  security_group_ports     = ["80", "8080", "443", "22", "943", "1194"]
}






