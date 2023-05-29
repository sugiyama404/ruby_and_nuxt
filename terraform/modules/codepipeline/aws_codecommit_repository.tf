resource "aws_codecommit_repository" "codecommit_repository" {
  repository_name = "${var.app_name}-repository"
  description     = "This is the ${var.app_name} App Repository"
}
