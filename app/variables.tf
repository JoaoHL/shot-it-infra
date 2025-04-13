variable "prefix" {
  type    = string
  default = "shot-it"
}


variable "cluster_name" {
  type    = string
  default = "8soat"
}

variable "instance_types" {
  type    = list(string)
  default = ["t3a.medium"]
}

variable "vpc_id" {
  type = string
}

variable "subnets_ids" {
  type = list(string)
}

variable "ssh_security_group_id" {
  type = string
}

variable "policy_arn" {
  type    = string
  default = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "authentication_mode" {
  type    = string
  default = "API_AND_CONFIG_MAP"
}

variable "principal_arn" {
  type    = string
  default = "arn:aws:iam::766294682390:role/voclabs"
}