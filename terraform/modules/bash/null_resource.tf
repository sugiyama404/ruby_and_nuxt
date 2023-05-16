resource "null_resource" "default" {
  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.self.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com"
  }

  #provisioner "local-exec" {
  #  command = "docker -t ${var.api_alb_target_group_arn}:latest --file ../${var.api_app_dir_name}/Dockerfile ../${var.api_app_dir_name}/"
  #}

  #provisioner "local-exec" {
  #  command = "docker -t ${var.web_alb_target_group_arn}:latest --file ../${var.web_app_dir_name}/Dockerfile ../${var.web_app_dir_name}/"
  #}

  provisioner "local-exec" {
    command = "docker push ${data.aws_caller_identity.self.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/${var.api_app_name}:latest"
  }

  provisioner "local-exec" {
    command = "docker push ${data.aws_caller_identity.self.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/${var.web_app_name}:latest"
  }
}
