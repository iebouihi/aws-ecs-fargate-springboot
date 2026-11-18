variable "name" {
  description = "Prefix used to name ALB resources."
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "target_port" {
  description = "Port the container listens on."
  type        = number
}

variable "health_check_path" {
  type = string
}

variable "allowed_ingress_cidrs" {
  description = "CIDRs allowed to reach the ALB on port 80."
  type        = list(string)
}
