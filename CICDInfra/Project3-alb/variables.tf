variable "lb_name" {}
variable "subnets" { type = list(string) }
variable "security_groups" { type = list(string) }
variable "project_name" {}
variable "env" {}
variable "target_group_name" {}
variable "target_group_port" { type = number }
variable "target_group_protocol" {}
variable "vpc_id" {}
variable "health_check_path" {}
variable "listener_port" { type = number }
variable "listener_protocol" {}

variable "instance_type" { type = string }
variable "key_name" { type = string }
variable "ami_id" { type = string }

variable "desired_capacity" { type = number }
variable "min_size" { type = number }
variable "max_size" { type = number }

variable "asg_subnets" { type = list(string) }
