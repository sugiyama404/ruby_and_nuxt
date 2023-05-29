resource "aws_iam_policy_attachment" "cws_policy_attachment" {

  name       = "${var.app_name}-cwe-policy"
  roles      = [aws_iam_role.cwe_role.name]
  policy_arn = aws_iam_policy.cwe_policy.arn
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRoleForECS" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
  role       = aws_iam_role.codedeploy-role.name
}

