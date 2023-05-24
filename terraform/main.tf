terraform {
  required_version = "=1.0.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# IAM
module "iam" {
  source   = "./modules/iam"
  app_name = var.app_name
}

# cloudwatch
module "cloudwatch" {
  source       = "./modules/cloudwatch"
  app_name     = var.app_name
  web_app_name = var.web_app_name
  api_app_name = var.api_app_name
}

# network
module "network" {
  source       = "./modules/network"
  app_name     = var.app_name
  web_app_name = var.web_app_name
  api_app_name = var.api_app_name
  http_ports   = var.http_ports
  https_ports  = var.https_ports
  web_ports    = var.web_ports
  api_ports    = var.api_ports
  db_ports     = var.db_ports
}

# s3
module "s3" {
  source   = "./modules/s3"
  app_name = var.app_name
}

# elb
module "elb" {
  source        = "./modules/elb"
  app_name      = var.app_name
  web_app_name  = var.web_app_name
  api_app_name  = var.api_app_name
  main_vpc_id   = module.network.main_vpc_id
  subnet_p1a_id = module.network.subnet_public_1a_id
  subnet_p1c_id = module.network.subnet_public_1c_id
  alb_sg_id     = module.network.alb_sg_id
  web_ports     = var.web_ports
  api_ports     = var.api_ports
  s3_bucket_id  = module.s3.s3_bucket_id
}

# ECR
module "ecr" {
  source       = "./modules/ecr"
  app_name     = var.app_name
  web_app_name = var.web_app_name
  api_app_name = var.api_app_name
}

# Null Resource
module "after_ecr" {
  source             = "./modules/bash"
  region             = var.region
  web_app_name       = var.web_app_name
  api_app_name       = var.api_app_name
  web_app_dir_name   = var.web_app_dir_name
  api_app_dir_name   = var.api_app_dir_name
  api_repository_url = module.ecr.api_repository_url
  web_repository_url = module.ecr.web_repository_url
}

# rds
module "rds" {
  source       = "./modules/rds"
  db_sbg_name  = module.network.db_sbg_name
  sg_rds_sg_id = module.network.sg_rds_sg_id
  db_ports     = var.db_ports
  app_name     = var.app_name
  db_name      = var.db_name
  db_username  = var.db_username
  db_password  = var.db_password
}

# ECS
module "ecs" {
  source             = "./modules/ecs"
  app_name           = var.app_name
  web_app_name       = var.web_app_name
  api_app_name       = var.api_app_name
  apserver_sg_id     = module.network.apserver_sg_id
  subnet_p1a_id      = module.network.subnet_public_1a_id
  webserver_sg_id    = module.network.webserver_sg_id
  subnet_p1c_id      = module.network.subnet_public_1c_id
  ecs_main_role      = module.iam.ecs_main_role
  db_endpoint        = module.rds.db_endpoint
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  api_blue_arn       = module.elb.api_blue_arn
  web_blue_arn       = module.elb.web_blue_arn
  api_green_arn      = module.elb.api_green_arn
  web_green_arn      = module.elb.web_green_arn
  web_ports          = var.web_ports
  api_ports          = var.api_ports
  http_arn           = module.elb.http_arn
  api_repository_url = module.ecr.api_repository_url
  web_repository_url = module.ecr.web_repository_url
}

# codepipeline
# module "codepipeline" {
#   source       = "./modules/codepipeline"
#   app_name     = var.app_name
#   web_app_name = var.web_app_name
#   api_app_name = var.api_app_name
# }
