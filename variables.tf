variable "environment" {
  type    = string
  default = "test"
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = "2"
}

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "aws_av_zones" {
  type = list
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}


# variable "s3_bucket_prefix" {
#   description = "Prefix for the s3 bucket"
#   type        = string
# }

# variable "s3_region" {
#   type    = string
#   default = "us-east-1a"
# }

# variable "ec2_instances_prefix" {
#   description = "Prefix for ec2 instances"
#   type = string
# }

# locals {
#   s3_tags = {
#     created_by  = "mes"
#     environment = var.environment
#   }

#   ec2_tags = {
#     created_by = "mes"
#     environment = var.environment
#   }
# }
