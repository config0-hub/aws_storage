output "cluster_identifier" {
  description = "The cluster identifier of the DocumentDB cluster"
  value       = aws_docdb_cluster.default.cluster_identifier
}

output "arn" {
  description = "The ARN of the DocumentDB cluster"
  value       = aws_docdb_cluster.default.arn
}

output "endpoint" {
  description = "The writer endpoint of the DocumentDB cluster"
  value       = aws_docdb_cluster.default.endpoint
}

output "reader_endpoint" {
  description = "The reader endpoint of the DocumentDB cluster"
  value       = aws_docdb_cluster.default.reader_endpoint
}

output "port" {
  description = "The port on which the cluster accepts connections"
  value       = aws_docdb_cluster.default.port
}

output "master_username" {
  description = "Username for the master DB user"
  value       = aws_docdb_cluster.default.master_username
}

# db_endpoint, db_port and db_name are the docdb_access target fields
output "db_endpoint" {
  description = "The writer endpoint of the DocumentDB cluster"
  value       = aws_docdb_cluster.default.endpoint
}

output "db_port" {
  description = "The port on which the cluster accepts connections"
  value       = aws_docdb_cluster.default.port
}

output "db_name" {
  description = "The database a grant targets"
  value       = var.db_name
}

output "db_subnet_group_name" {
  description = "The name of the DocumentDB subnet group"
  value       = aws_docdb_cluster.default.db_subnet_group_name
}

output "engine_version" {
  description = "The DocumentDB engine version of the cluster"
  value       = aws_docdb_cluster.default.engine_version
}

output "instance_class" {
  description = "The instance class of the cluster instance"
  value       = aws_docdb_cluster_instance.default.instance_class
}

output "storage_encrypted" {
  description = "Whether the DocumentDB cluster is encrypted at rest"
  value       = aws_docdb_cluster.default.storage_encrypted
}
