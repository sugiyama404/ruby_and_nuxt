resource "null_resource" "init_db" {
  triggers = {
    cluster_arn         = aws_ecs_cluster.cluster.arn
    task_definition_arn = aws_ecs_task_definition.api-definition.arn
  }
  provisioner "local-exec" {
    command = <<EOT
    aws ecs run-task \
      --region $AWS_DEFAULT_REGION \
      --launch-type FARGATE \
      --network-configuration "awsvpcConfiguration={subnets=[$SUBNET_ID],securityGroups=[$SECURITY_GROUP_ID],assignPublicIp=ENABLED}" \
      --cluster $CLUSTER_NAME \
      --task-definition $TASK_NAME \
      --overrides "{\"containerOverrides\": [{\"name\": \"apiserver\",\"command\": [\"rails\", \"db:migrate\"]}]}"
EOT


    interpreter = ["/bin/bash", "-c"]

    environment = {
      AWS_DEFAULT_REGION = "ap-northeast-1"
      SUBNET_ID          = var.subnet_p1a_id
      SECURITY_GROUP_ID  = var.apserver_sg_id
      CLUSTER_NAME       = aws_ecs_cluster.cluster.name
      TASK_NAME          = aws_ecs_task_definition.api-definition.family
    }
  }

  depends_on = [
    aws_ecs_cluster.cluster,
    aws_ecs_task_definition.api-definition
  ]
}

