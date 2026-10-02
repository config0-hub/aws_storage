# cache_name, cache_type, user_group_id and engine are the names the
# elasticache_access grant stack takes; the write-back puts every output on
# the resource row under its output name.
output "cache_name" {
  description = "The replication group id of the ElastiCache cache"
  value       = aws_elasticache_replication_group.default.id
}

output "cache_type" {
  description = "The ElastiCache cache type, replication_group or serverless"
  value       = "replication_group"
}

output "user_group_id" {
  description = "The id of the ElastiCache user group attached to the cache"
  value       = aws_elasticache_user_group.default.user_group_id
}

output "engine" {
  description = "The cache engine"
  value       = aws_elasticache_replication_group.default.engine
}

output "engine_version" {
  description = "The running engine version of the cache"
  value       = aws_elasticache_replication_group.default.engine_version_actual
}

output "arn" {
  description = "The ARN of the ElastiCache replication group"
  value       = aws_elasticache_replication_group.default.arn
}

output "primary_endpoint_address" {
  description = "The address of the primary node endpoint"
  value       = aws_elasticache_replication_group.default.primary_endpoint_address
}

output "reader_endpoint_address" {
  description = "The address of the reader endpoint"
  value       = aws_elasticache_replication_group.default.reader_endpoint_address
}

output "port" {
  description = "The port on which the cache accepts connections"
  value       = aws_elasticache_replication_group.default.port
}

output "node_type" {
  description = "The node type of the cache nodes"
  value       = aws_elasticache_replication_group.default.node_type
}

output "num_cache_clusters" {
  description = "The number of cache nodes in the replication group"
  value       = aws_elasticache_replication_group.default.num_cache_clusters
}

output "subnet_group_name" {
  description = "The name of the ElastiCache subnet group"
  value       = aws_elasticache_replication_group.default.subnet_group_name
}

output "at_rest_encryption_enabled" {
  description = "Whether the cache is encrypted at rest"
  value       = aws_elasticache_replication_group.default.at_rest_encryption_enabled
}

output "transit_encryption_enabled" {
  description = "Whether the cache is encrypted in transit"
  value       = aws_elasticache_replication_group.default.transit_encryption_enabled
}
