# SecurityGroup for Fargate alb
resource "aws_security_group" "alb_sg" {
  name   = "${var.app_name}-alb-sg"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.app_name}-alb-sg"
  }
}

# SecurityGroup for Fargate api
resource "aws_security_group" "apserver_sg" {
  name   = "${var.api_app_name}-sg"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.app_name}-${var.api_app_name}-sg"
  }
}

# SecurityGroup for Fargate web
resource "aws_security_group" "webserver_sg" {
  name   = "${var.web_app_name}-sg"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-${var.web_app_name}-sg"
  }
}

# SecurityGroup for RDS
resource "aws_security_group" "rds_sg" {
  name   = "rds-sg"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-rds-sg"
  }
}
