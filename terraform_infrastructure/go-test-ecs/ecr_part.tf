resource "aws_ecr_repository" "go-test-repo" {
  name                 = "go-test"
  force_delete         = true
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}
