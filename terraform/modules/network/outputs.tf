output "main_vpc_id" {
  value = aws_vpc.main.id
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "apserver_sg_id" {
  value = aws_security_group.apserver_sg.id
}

output "webserver_sg_id" {
  value = aws_security_group.webserver_sg.id
}

output "subnet_public_1a_id" {
  value = aws_subnet.public_subnet_1a.id
}

output "subnet_public_1c_id" {
  value = aws_subnet.public_subnet_1c.id
}

output "db_sbg_name" {
  value = aws_db_subnet_group.db-sg.name
}

output "sg_rds_sg_id" {
  value = aws_security_group.rds_sg.id
}
