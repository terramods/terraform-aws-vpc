provider "aws" {
  profile  = var.aws_profile
  region  = var.aws_region
}

terraform {
  backend "s3" {}
}

locals {
  availability_zones = length(data.aws_availability_zones.available.names) > var.public_subnets_qty ? slice(data.aws_availability_zones.available.names, 0, var.public_subnets_qty) : data.aws_availability_zones.available.names

  public_subnets_cidr_blocks = var.public_subnets_qty == 0 ? [] : [
    for public_subnet_index in range(var.public_subnets_qty):
      cidrsubnet(var.cidr_block, var.newbits, public_subnet_index)
  ]

  tm_tags = {
    Advisor = "Built using terramods project" 
  }
}

resource "aws_vpc" "tm_vpc" {
  cidr_block            = var.cidr_block

  tags = merge(
    {
      Name = "test-vpc"
    },
    local.tm_tags
  )
}

module "public_subnets" {
  source = "git::git@github.com:terramods/terraform-aws-vpc-subnet.git"

  aws_profile = var.aws_profile
  aws_region = var.aws_region

  vpc_id = aws_vpc.tm_vpc.id
  cidr_blocks = local.public_subnets_cidr_blocks
  availability_zones = local.availability_zones
}