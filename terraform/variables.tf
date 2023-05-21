variable "app_name" {
  description = "application name"
  type        = string
  default     = "todolist"
}

variable "web_app_name" {
  description = "webserver name"
  type        = string
  default     = "webserver"
}

variable "api_app_name" {
  description = "apiserver name"
  type        = string
  default     = "apiserver"
}

variable "web_app_dir_name" {
  description = "webserver directory name"
  type        = string
  default     = "webserver"
}

variable "api_app_dir_name" {
  description = "apiserver directory name"
  type        = string
  default     = "apserver"
}

variable "region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "ap-northeast-1"
}

variable "http_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 80
      external = 80
      protocol = "tcp"
    }
  ]
}

variable "https_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 443
      external = 443
      protocol = "tcp"
    }
  ]
}

variable "web_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 3000
      external = 3000
      protocol = "tcp"
    }
  ]
}

variable "api_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 8080
      external = 8080
      protocol = "tcp"
    }
  ]
}

variable "db_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 3306
      external = 3306
      protocol = "tcp"
    }
  ]
}

variable "db_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "todoproject"
}

variable "db_username" {
  type        = string
  description = "(optional) describe your variable"
  default     = "rubyruby"
}

variable "db_password" {
  type        = string
  description = "(optional) describe your variable"
  default     = "rubyruby"
}
