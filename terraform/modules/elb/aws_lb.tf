resource "aws_lb" "alb" {
  name                       = "${var.app_name}-alb"
  internal                   = false
  enable_deletion_protection = false
  load_balancer_type         = "application"
  security_groups            = ["${var.alb_sg_id}"]
  subnets = [
    "${var.subnet_p1a_id}",
    "${var.subnet_p1c_id}"
  ]
  access_logs {
    bucket  = var.s3_bucket_id
    prefix  = "access-log"
    enabled = true
  }

}
