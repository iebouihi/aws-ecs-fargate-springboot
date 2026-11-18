variable "name" {
  description = "Prefix used to name network resources."
  type        = string
}

variable "aws_region" {
  description = "AWS region (used for the S3 VPC endpoint service name)."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC."
  type        = string
}

variable "az_count" {
  description = "Number of Availability Zones to spread subnets across."
  type        = number
}

variable "nat_gateway_mode" {
  description = "single = one shared NAT, per_az = one NAT per AZ (HA), none = no NAT."
  type        = string
}
