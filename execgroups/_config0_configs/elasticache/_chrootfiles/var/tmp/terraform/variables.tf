variable "aws_default_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "cache_name" {
  description = "The replication group id of the ElastiCache cache"
  type        = string
  default     = "test-cache"
}

variable "cache_subnet_name" {
  description = "The name of the ElastiCache subnet group"
  type        = string
  default     = "cache_subnet_name"
}

variable "user_group_id" {
  description = "The id of the ElastiCache user group attached to the cache"
  type        = string
  default     = "test-cache-users"
}

variable "default_user_password" {
  description = "Password of the disabled default user in the user group"
  type        = string
  sensitive   = true
}

variable "engine" {
  description = "The cache engine, redis or valkey"
  type        = string
  default     = "redis"
}

variable "engine_version" {
  description = "The engine version; IAM authentication needs Redis OSS 7 or later, or Valkey 7.2 or later"
  type        = string
  default     = "7.1"
}

variable "node_type" {
  description = "The node type of the cache nodes"
  type        = string
  default     = "cache.t4g.micro"
}

variable "num_cache_clusters" {
  description = "The number of cache nodes in the replication group; more than 1 turns on automatic failover"
  type        = number
  default     = 1
}

variable "port" {
  description = "The port on which the cache accepts connections"
  type        = number
  default     = 6379
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of VPC security group IDs to associate with the cache"
}

variable "subnet_ids" {
  description = "List of subnet IDs to include in the cache subnet group"
  type        = list(string)
}

variable "cloud_tags" {
  description = "Additional tags as a map to apply to all resources"
  type        = map(string)
  default     = {}
}
