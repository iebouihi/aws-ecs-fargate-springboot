# Dev environment settings. image_tag is NOT set here: the pipeline passes it.

aws_region   = "eu-north-1"
project_name = "springboot-ecs"
environment  = "dev"

# Network
vpc_cidr         = "10.0.0.0/16"
az_count         = 2
nat_gateway_mode = "single" # single | per_az | none

# Fargate task size
task_cpu         = 512  # 0.5 vCPU
task_memory      = 1024 # 1 GB
cpu_architecture = "X86_64"
use_fargate_spot = false

# Scaling
desired_count = 2
min_capacity  = 2
max_capacity  = 4

# Ops
log_retention_days        = 14
enable_container_insights = true
enable_execute_command    = true

extra_tags = {
  Owner = "iebouihi"
}
