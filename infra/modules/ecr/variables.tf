variable "name" {
  description = "ECR repository name."
  type        = string
}

variable "image_tag_mutability" {
  description = "MUTABLE or IMMUTABLE. IMMUTABLE prevents overwriting a deployed tag."
  type        = string
}

variable "max_image_count" {
  description = "Number of images to keep in the repository."
  type        = number
}

variable "force_delete" {
  description = "Delete the repository even if it contains images."
  type        = bool
}
