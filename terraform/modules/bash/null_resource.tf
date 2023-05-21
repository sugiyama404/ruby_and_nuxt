resource "null_resource" "default" {
  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.self.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com"
  }

  # provisioner "local-exec" {
  #   command = "docker build -t ${var.api_repository_url}:latest --file ../${var.api_app_dir_name}/Dockerfile ../${var.api_app_dir_name}/"
  # }

  # provisioner "local-exec" {
  #   command = "docker build -t ${var.web_repository_url}:latest --file ../${var.web_app_dir_name}/Dockerfile ../${var.web_app_dir_name}/"
  # }

  provisioner "local-exec" {
    command = "docker push ${var.api_repository_url}:latest"
  }

  provisioner "local-exec" {
    command = "docker push ${var.web_repository_url}:latest"
  }
}
