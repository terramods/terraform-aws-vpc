locals {
  tm_tags = {}
}

resource "aws_vpc" "tm_vpc" {
  cidr_block            = var.cidr_block

  tags = merge(
    {},
    local.tm_tags
  )
}