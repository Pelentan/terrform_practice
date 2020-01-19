variable "environment" {
  type    = string
  default = "dev"
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

variable "aws_region_ami" {
  type = map
  default = {
    "us-east-1" = "ami-062f7200baf2fa504"
    "us-east-2" = "ami-02ccb28830b645a41"
    "us-west-1" = "ami-03caa3f860895f82e"
    "us-west-2" = "ami-04590e7389a6e577c"
  }
}

variable "cider_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "subnets" {
  type = map
  default = {
    "pub1" = "10.0.1.0/24"
    "pub2" = "10.0.2.0/24"
    "pub3" = "10.0.3.0/24"
    "pri1" = "10.0.4.0/24"
    "pri2" = "10.0.5.0/24"
    "pri3" = "10.0.6.0/24"
  }
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
