# ---------------------------------------------------------------------------
# General
# ---------------------------------------------------------------------------
variable "aws_region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Short project name, used as a prefix for all resources."
  type        = string
  default     = "springboot-ecs"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,20}$", var.project_name))
    error_message = "Use 3-20 lowercase letters, digits or hyphens (ALB names are limited to 32 chars)."
  }
}

variable "environment" {
  description = "Environment name (dev, staging, prod...)."
  type        = string
  default     = "dev"
}

variable "extra_tags" {
  description = "Additional tags applied to every resource."
  type        = map(string)
  default     = {}
}

# ---------------------------------------------------------------------------
# Network
# ---------------------------------------------------------------------------
variable "vpc_cidr" {
  description = "CIDR block of the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of Availability Zones (the ALB needs at least 2)."
  type        = number
  default     = 2

  validation {
    condition     = var.az_count >= 2 && var.az_count <= 3
    error_message = "az_count must be 2 or 3."
  }
}

variable "nat_gateway_mode" {
  description = "single = one shared NAT (cheapest private setup), per_az = one NAT per AZ (HA), none = tasks in public subnets."
  type        = string
  default     = "single"

  validation {
    condition     = contains(["single", "per_az", "none"], var.nat_gateway_mode)
    error_message = "nat_gateway_mode must be single, per_az or none."
  }
}

variable "alb_allowed_cidrs" {
  description = "CIDRs allowed to reach the ALB on HTTP/80."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# ---------------------------------------------------------------------------
# Container image (ECR)
# ---------------------------------------------------------------------------
variable "image_tag" {
  description = "Image tag to deploy. The pipeline sets it to the Git commit SHA."
  type        = string
}

variable "ecr_image_tag_mutability" {
  description = "MUTABLE or IMMUTABLE."
  type        = string
  default     = "IMMUTABLE"
}

variable "ecr_max_image_count" {
  description = "How many images ECR keeps before expiring older ones."
  type        = number
  default     = 15
}

variable "ecr_force_delete" {
  description = "Allow terraform destroy to delete the repository even if it holds images."
  type        = bool
  default     = true
}

# ---------------------------------------------------------------------------
# Application / Fargate task
# ---------------------------------------------------------------------------
variable "container_port" {
  description = "Port the Spring Boot app listens on."
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "HTTP path used by the ALB and container health checks."
  type        = string
  default     = "/actuator/health"
}

variable "task_cpu" {
  description = "Fargate task CPU units (256, 512, 1024, 2048, 4096...)."
  type        = number
  default     = 512
}

variable "task_memory" {
  description = "Fargate task memory in MiB (must be valid for the chosen CPU)."
  type        = number
  default     = 1024
}

variable "cpu_architecture" {
  description = "X86_64 or ARM64 (Graviton, cheaper; the image must be built for arm64)."
  type        = string
  default     = "X86_64"

  validation {
    condition     = contains(["X86_64", "ARM64"], var.cpu_architecture)
    error_message = "cpu_architecture must be X86_64 or ARM64."
  }
}

variable "use_fargate_spot" {
  description = "Run tasks on Fargate Spot (up to ~70% cheaper, can be interrupted)."
  type        = bool
  default     = false
}

# ---------------------------------------------------------------------------
# Scaling
# ---------------------------------------------------------------------------
variable "desired_count" {
  description = "Initial number of tasks (autoscaling takes over afterwards)."
  type        = number
  default     = 2
}

variable "min_capacity" {
  description = "Minimum number of tasks."
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "Maximum number of tasks."
  type        = number
  default     = 4
}

variable "autoscaling_cpu_target" {
  description = "Average CPU % the service scales to keep."
  type        = number
  default     = 60
}

variable "autoscaling_memory_target" {
  description = "Average memory % the service scales to keep."
  type        = number
  default     = 75
}

# ---------------------------------------------------------------------------
# Observability / operations
# ---------------------------------------------------------------------------
variable "log_retention_days" {
  description = "CloudWatch log retention."
  type        = number
  default     = 14
}

variable "enable_container_insights" {
  description = "Enable ECS Container Insights metrics (small extra CloudWatch cost)."
  type        = bool
  default     = true
}

variable "enable_execute_command" {
  description = "Allow `aws ecs execute-command` into running tasks."
  type        = bool
  default     = true
}
