locals {
  name = "${var.project_name}-${var.environment}"

  # With a NAT gateway, tasks live in private subnets with no public IP.
  # Without one, they need public subnets + a public IP to reach ECR.
  use_private_subnets = var.nat_gateway_mode != "none"
}

module "network" {
  source = "./modules/network"

  name             = local.name
  aws_region       = var.aws_region
  vpc_cidr         = var.vpc_cidr
  az_count         = var.az_count
  nat_gateway_mode = var.nat_gateway_mode
}

module "ecr" {
  source = "./modules/ecr"

  name                 = local.name
  image_tag_mutability = var.ecr_image_tag_mutability
  max_image_count      = var.ecr_max_image_count
  force_delete         = var.ecr_force_delete
}

module "alb" {
  source = "./modules/alb"

  name                  = local.name
  vpc_id                = module.network.vpc_id
  vpc_cidr              = module.network.vpc_cidr
  public_subnet_ids     = module.network.public_subnet_ids
  target_port           = var.container_port
  health_check_path     = var.health_check_path
  allowed_ingress_cidrs = var.alb_allowed_cidrs
}

module "ecs" {
  source = "./modules/ecs"

  name        = local.name
  environment = var.environment
  vpc_id      = module.network.vpc_id

  subnet_ids       = local.use_private_subnets ? module.network.private_subnet_ids : module.network.public_subnet_ids
  assign_public_ip = !local.use_private_subnets

  alb_security_group_id = module.alb.security_group_id
  target_group_arn      = module.alb.target_group_arn

  ecr_repository_url = module.ecr.repository_url
  image_tag          = var.image_tag

  container_port    = var.container_port
  health_check_path = var.health_check_path
  cpu               = var.task_cpu
  memory            = var.task_memory
  cpu_architecture  = var.cpu_architecture

  desired_count         = var.desired_count
  min_capacity          = var.min_capacity
  max_capacity          = var.max_capacity
  cpu_target_percent    = var.autoscaling_cpu_target
  memory_target_percent = var.autoscaling_memory_target
  use_fargate_spot      = var.use_fargate_spot

  log_retention_days        = var.log_retention_days
  enable_container_insights = var.enable_container_insights
  enable_execute_command    = var.enable_execute_command
}
