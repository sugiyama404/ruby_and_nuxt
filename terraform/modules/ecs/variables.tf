variable "app_name" {}
variable "web_app_name" {}
variable "api_app_name" {}
variable "apserver_sg_id" {}
variable "subnet_p1a_id" {}
variable "webserver_sg_id" {}
variable "subnet_p1c_id" {}
variable "ecs_main_role" {}
variable "db_endpoint" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
variable "web_ports" {}
variable "api_ports" {}
variable "http_arn" {}
variable "api_alb_target_group_arn" {}
variable "web_alb_target_group_arn" {}
data "aws_caller_identity" "self" {}
