/*
  AWS provider configuration.  
*/

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {}

# VPC
resource "aws_vpc" "main" {
  cidr_block = var.cider_block
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  tags = {
    Name = "main"
  }
}

# Subnets -- Public
resource "aws_subnet" "main-public-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnets["pub1"]
  map_public_ip_on_launch =  true
  availability_zone = var.aws_av_zones[0]

  tags = {
    Name = "main-public-1"
  }
}

resource "aws_subnet" "main-public-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnets["pub2"]
  map_public_ip_on_launch =  true
  availability_zone = var.aws_av_zones[1]

  tags = {
    Name = "main-public-2"
  }
}

resource "aws_subnet" "main-public-3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnets["pub3"]
  map_public_ip_on_launch =  true
  availability_zone = var.aws_av_zones[2]

  tags = {
    Name = "main-public-3"
  }
}

# Subnets -- Private
resource "aws_subnet" "main-private-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnets["pri1"]
  map_public_ip_on_launch =  false
  availability_zone = var.aws_av_zones[0]

  tags = {
    Name = "main-private-1"
  }
}

resource "aws_subnet" "main-private-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnets["pri2"]
  map_public_ip_on_launch =  false
  availability_zone = var.aws_av_zones[1]

  tags = {
    Name = "main-private-2"
  }
}

resource "aws_subnet" "main-private-3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnets["pri3"]
  map_public_ip_on_launch =  false
  availability_zone = var.aws_av_zones[2]

  tags = {
    Name = "main-private-3"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id 

  tags = {
    Name = "main"
  }
}

# Route Tables
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "main-public-1"
  }  
}

#Route Association Public
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id = aws_subnet.main-public-1.id 
  route_table_id = aws_route_table.main-public.id
}
resource "aws_route_table_association" "main-public-2-a" {
  subnet_id = aws_subnet.main-public-2.id 
  route_table_id = aws_route_table.main-public.id
}
resource "aws_route_table_association" "main-public-3-a" {
  subnet_id = aws_subnet.main-public-3.id 
  route_table_id = aws_route_table.main-public.id
}

