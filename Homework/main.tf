terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #   version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.region
  access_key = "AKIAJRBO6OMREPE5NZXA"
  secret_key = "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"
}

module "network" {
  source = "./modules/network"
  vpc_cidr = "10.0.0.0/16"
  private_subnet_cidr = "10.0.1.0/24"
  public_subnet_cidr  = "10.0.0.0/24"
  availability_zones  = "us-east-2b"
}

# 2 security groups (Nginx and mysql)
module "security-group" {
  source = "./modules/security-groups"
  vpc_id = module.network.vpc_id
}
# create a instance of NGINX
module "instances" {
  source        = "./modules/instances"
  sg            = module.security-group.sg_nginx
  subnet        = module.network.public_subnet
  ami           = var.ami
  tag_name      = "nginx"
  file          = "./nginx.sh"
}
# create a instance of mysql
module "instances2" {
  source        = "./modules/instances"
  sg            = module.security-group.sg_mysql
  subnet        = module.network.private_subnet
  ami           = var.ami
  tag_name      = "mysql"
  file          = "./mysql.sh"
}

