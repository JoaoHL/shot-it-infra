variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "eks_principal_arn" {
  type    = string
  default = "arn:aws:iam::766294682390:role/voclabs"
}