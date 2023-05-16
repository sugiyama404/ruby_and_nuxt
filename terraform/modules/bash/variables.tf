data "aws_caller_identity" "self" {}
variable "api_app_name" {}
variable "api_app_dir_name" {}
variable "web_app_name" {}
variable "web_app_dir_name" {}
variable "api_alb_target_group_arn" {}
variable "web_alb_target_group_arn" {}
variable "region" {}
