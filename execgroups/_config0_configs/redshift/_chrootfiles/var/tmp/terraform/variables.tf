variable "db_name" {
  description = "The name of the first database created when the cluster is created"
  type        = string
  default     = "dev"
}

variable "aws_default_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "redshift_name" {
  description = "The cluster identifier of the Redshift cluster"
  type        = string
  default     = "test-redshift"
}

variable "cluster_subnet_name" {
  description = "The name of the Redshift cluster subnet group"
  type        = string
  default     = "cluster_subnet_name"
}

variable "master_username" {
  description = "Username for the master DB user"
  type        = string
  sensitive   = true
}

variable "master_password" {
  description = "Password for the master DB user"
  type        = string
  sensitive   = true
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of VPC security group IDs to associate with the Redshift cluster"
}

variable "subnet_ids" {
  description = "List of subnet IDs to include in the cluster subnet group"
  type        = list(string)
}

variable "node_type" {
  description = "The node type of the Redshift cluster"
  type        = string
  default     = "ra3.large"
}

variable "number_of_nodes" {
  description = "The number of compute nodes; 1 makes a single-node cluster"
  type        = number
  default     = 1
}

variable "port" {
  description = "The port on which the cluster accepts connections"
  type        = number
  default     = 5439
}

variable "publicly_accessible" {
  description = "Controls if the cluster is publicly accessible"
  type        = bool
  default     = false
}

variable "encrypted" {
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
