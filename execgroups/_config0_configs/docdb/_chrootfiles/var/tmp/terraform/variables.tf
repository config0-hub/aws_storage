variable "db_name" {
  description = "The database a grant targets; DocumentDB creates it on first write. Output only."
  type        = string
  default     = "app"
}

variable "aws_default_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "docdb_name" {
  description = "The cluster identifier of the DocumentDB cluster"
  type        = string
  default     = "test-docdb"
}

variable "db_subnet_name" {
  description = "The name of the DocumentDB subnet group"
  type        = string
  default     = "db_subnet_name"
}

# not sensitive: the cluster's master_username is an output
variable "master_username" {
  description = "Username for the master DB user"
  type        = string
}

variable "master_password" {
  description = "Password for the master DB user"
  type        = string
  sensitive   = true
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of VPC security group IDs to associate with the DocumentDB cluster"
}

variable "subnet_ids" {
  description = "List of subnet IDs to include in the DocumentDB subnet group"
  type        = list(string)
}

variable "engine_version" {
  description = "The DocumentDB engine version; IAM authentication needs 5.0"
  type        = string
  default     = "5.0.0"
}

variable "instance_class" {
  description = "The instance class of the cluster instance"
  type        = string
  default     = "db.t3.medium"
}

variable "port" {
  description = "The port on which the cluster accepts connections"
  type        = number
  default     = 27017
}

variable "storage_encrypted" {
  description = "Specifies whether the cluster is encrypted at rest"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Determines whether a final snapshot is created before the cluster is deleted"
  type        = bool
  default     = true
}

variable "cloud_tags" {
  description = "Additional tags as a map to apply to all resources"
  type        = map(string)
  default     = {}
}
