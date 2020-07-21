provider "aws" {
  profile  = var.aws_profile
  region  = var.aws_region
}

terraform {
  backend "s3" {}
}

locals {
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