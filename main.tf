provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source = "./shared"

  vpc_cidr = var.vpc_cidr
}

module "app" {
  source = "./app"

  prefix       = "shot-it"
  cluster_name = "8soat"

  principal_arn         = var.eks_principal_arn
  vpc_id                = module.vpc.vpc_id
  subnets_ids           = module.vpc.subnets_ids
  ssh_security_group_id = module.vpc.ssh_security_group_id
}

terraform {
  cloud {
    organization = "postech-fiap-alura"
    workspaces {
      name = "shot-it"
    }
  }
}