variable "aws_default_region" {
  type        = string
  description = "The AWS region where resources will be created (e.g., ap-southeast-1)"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone where the EBS volume will be created"
}

variable "volume_size" {
  type        = number
  description = "The size of the EBS volume in GiB"
  default     = 10
}

variable "volume_name" {
  type        = string
  description = "The name to assign to the EBS volume"
  default     = "data"
}

variable "volume_type" {
  type        = string
  description = "The type of EBS volume (gp2, gp3, io1, io2, sc1, st1, standard)"
  default     = "gp2"
}

variable "cloud_tags" {
  description = "Additional tags to apply to the EBS volume as a map"
  type        = map(string)
  default     = {}
}

