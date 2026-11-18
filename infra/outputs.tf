output "alb_url" {
  description = "Public URL of the application (AWS-provided ALB DNS name)."
  value       = "http://${module.alb.dns_name}"
}

output "alb_dns_name" {
  value = module.alb.dns_name
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "ecr_repository_name" {
  value = module.ecr.repository_name
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "ecs_service_name" {
  value = module.ecs.service_name
}

output "cloudwatch_log_group" {
  value = module.ecs.log_group_name
}

output "nat_public_ips" {
  description = "Outbound IPs of the tasks."
  value       = module.network.nat_public_ips
}

output "deployed_image_tag" {
  value = var.image_tag
}
