output "vpc" {
    value = aws_vpc.tm_vpc.id
}

output "public_subnets" {
    value = module.public_subnets.subnet_ids
}

output "private_subnets" {
    value = module.private_subnets.subnet_ids
}