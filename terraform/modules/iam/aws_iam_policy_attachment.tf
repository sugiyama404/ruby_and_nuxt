resource "aws_iam_policy_attachment" "ecr_attach" {
  name       = "${var.app_name}-ecr_attach"
  roles      = ["${aws_iam_role.main_role.name}"]
  policy_arn = aws_iam_policy.ecr_policy.arn
}

resource "aws_iam_policy_attachment" "cloudwatch_attach" {
  name       = "${var.app_name}_cloudwatch_attach"
  roles      = ["${aws_iam_role.main_role.name}"]
  policy_arn = aws_iam_policy.cloudwatch_policy.arn
}

resource "aws_iam_policy_attachment" "ecs_task_role_attach" {
  name       = "${var.app_name}_ecs_task_role_attach"
  roles      = ["${aws_iam_role.main_role.name}"]
  policy_arn = aws_iam_policy.ecs_task_role_policy.arn
}
