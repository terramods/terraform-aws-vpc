variable "aws_profile" {
  type = string
  default = "default"
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "newbits" {
  type = number
  default = 4
}

variable "subnets" {
  type = list(
    object({
      kind = string
      qty = number
    })
  )
}