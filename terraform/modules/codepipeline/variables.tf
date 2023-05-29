variable "app_name" {}
variable "web_app_name" {}
variable "api_app_name" {}
variable "api_blue_arn" {}
variable "web_blue_arn" {}
variable "api_green_arn" {}
variable "web_green_arn" {}
variable "http_arn" {}
variable "cluster-name" {}
variable "api-service-name" {}
variable "web-service-name" {}
variable "api-definition-arn" {}
variable "web-definition-arn" {}

data "aws_caller_identity" "self" {}
