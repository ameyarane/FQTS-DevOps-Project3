variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = null
}
variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}
variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}
variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = null
}
variable "name" {
  description = "name of the instance."
  type        = string
  default     = null
}
variable "project_name" {
  description = "name of the project"
  type        = string
  default     = null
}
variable "env" {
  description = "env details"
  type        = string
  default     = null
}
 
variable "company_name" {
  description = "company_name "
  type        = string
  default     = "FQTS"
}
 
variable "user_data" {
  description = "user_data "
  type        = string
  default     = ""
}
 
variable "iam_instance_profile" {
  description = "iam_instance_profile"
  type        = string
  default     = ""
}