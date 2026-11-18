provider "aws" {
  region = var.aws_region

  # Applied to every resource that supports tags
  default_tags {
    tags = merge(
      {
        Project     = var.project_name
        Environment = var.environment
        ManagedBy   = "terraform"
        Repository  = "iebouihi/aws-ecs-fargate-springboot"
      },
      var.extra_tags,
    )
  }
}
