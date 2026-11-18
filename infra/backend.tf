# Remote state in S3 (partial configuration).
#
# bucket and region are NOT hard-coded: they are passed at init time, e.g.
#   terraform init \
#     -backend-config="bucket=<your-state-bucket>" \
#     -backend-config="region=eu-north-1"
#
# Locking uses S3 native lock files (no DynamoDB table needed).
terraform {
  backend "s3" {
    key          = "aws-ecs-fargate-springboot/dev/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}
