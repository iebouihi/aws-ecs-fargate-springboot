variable "name" {
  description = "Prefix used to name ECS resources."
  type        = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  description = "Subnets the tasks run in (private when a NAT gateway exists)."
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Give tasks a public IP (only needed when there is no NAT gateway)."
  type        = bool
}

variable "alb_security_group_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "ecr_repository_url" {
  type = string
}

variable "image_tag" {
  type = string
}

variable "container_port" {
  type = number
}

variable "health_check_path" {
  type = string
}

variable "cpu" {
  description = "Task CPU units (256 = 0.25 vCPU)."
  type        = number
}

variable "memory" {
  description = "Task memory in MiB."
  type        = number
}

variable "cpu_architecture" {
  description = "X86_64 or ARM64."
  type        = string
}

variable "desired_count" {
  type = number
}

variable "min_capacity" {
  type = number
}

variable "max_capacity" {
  type = number
}

variable "cpu_target_percent" {
  type = number
}

variable "memory_target_percent" {
  type = number
}

variable "use_fargate_spot" {
  type = bool
}

variable "log_retention_days" {
  type = number
}

variable "enable_container_insights" {
  type = bool
}

variable "enable_execute_command" {
  type = bool
}
