resource "aws_ecr_repository" "go-test-repo" {
  name                 = var.common_name
  force_delete         = true
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}
