# SecurityGroupRules for ALB
resource "aws_security_group_rule" "alb_in_http" {
  type              = "ingress"
  from_port         = var.http_ports[0].internal
  to_port           = var.http_ports[0].external
  protocol          = var.http_ports[0].protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "alb_out_full" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}

# SecurityGroupRules for Fargate api
resource "aws_security_group_rule" "apserver_in_alb" {
  type              = "ingress"
  from_port         = var.api_ports[0].internal
  to_port           = var.api_ports[0].external
  protocol          = var.api_ports[0].protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apserver_sg.id
}

resource "aws_security_group_rule" "apserver_out_db" {
  type              = "egress"
  from_port         = var.db_ports[0].internal
  to_port           = var.db_ports[0].external
  protocol          = var.db_ports[0].protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apserver_sg.id
}

resource "aws_security_group_rule" "apserver_out_http" {
  type              = "egress"
  from_port         = var.http_ports[0].internal
  to_port           = var.http_ports[0].external
  protocol          = var.http_ports[0].protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apserver_sg.id
}

resource "aws_security_group_rule" "apserver_out_https" {
  type              = "egress"
  from_port         = var.https_ports[0].internal
  to_port           = var.https_ports[0].external
  protocol          = var.https_ports[0].protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apserver_sg.id
}

# SecurityGroupRules for Fargate web
resource "aws_security_group_rule" "webserver_in_alb" {
  type              = "ingress"
  from_port         = var.web_ports[0].internal
  to_port           = var.web_ports[0].external
  protocol          = var.web_ports[0].protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver_sg.id
}

resource "aws_security_group_rule" "webserver_out_http" {
  type              = "egress"
  from_port         = var.http_ports[0].internal
  to_port           = var.http_ports[0].external
  protocol          = var.http_ports[0].protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver_sg.id
}

resource "aws_security_group_rule" "webserver_out_https" {
  type              = "egress"
  from_port         = var.https_ports[0].internal
  to_port           = var.https_ports[0].external
  protocol          = var.https_ports[0].protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver_sg.id
}

# SecurityGroupRules for db
resource "aws_security_group_rule" "rds_in_api" {
  type                     = "ingress"
  from_port                = var.db_ports[0].internal
  to_port                  = var.db_ports[0].external
  protocol                 = var.db_ports[0].protocol
  source_security_group_id = aws_security_group.apserver_sg.id
  security_group_id        = aws_security_group.rds_sg.id
}
