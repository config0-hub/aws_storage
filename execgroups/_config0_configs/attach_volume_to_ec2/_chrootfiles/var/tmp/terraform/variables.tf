variable "aws_default_region" {
  type        = string
  default     = "us-west-1"
  description = "AWS region where resources will be deployed, e.g. ap-southeast-1"
}

variable "volume_id" {
  type        = string
  description = "ID of the EBS volume to attach to the instance"
}

variable "device_name" {
  type        = string
  description = "Device name to expose to the instance"
  default     = "/dev/xvdc"
}

variable "instance_id" {
  type        = string
  description = "ID of the instance to attach the volume to"
}

variable "cloud_tags" {
  description = "Additional tags to apply to resources as a map"
  type        = map(string)
  default     = {}
}