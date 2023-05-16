resource "aws_db_parameter_group" "db-pg" {
  name   = "${var.app_name}-db-pg"
  family = "mysql8.0"

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}
