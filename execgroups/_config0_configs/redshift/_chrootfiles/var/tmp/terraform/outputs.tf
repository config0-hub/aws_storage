output "cluster_identifier" {
  description = "The cluster identifier of the Redshift cluster"
  value       = aws_redshift_cluster.default.cluster_identifier
}

output "arn" {
  description = "The ARN of the Redshift cluster"
  value       = aws_redshift_cluster.default.arn
}

output "cluster_namespace_arn" {
  description = "The namespace ARN of the Redshift cluster"
  value       = aws_redshift_cluster.default.cluster_namespace_arn
}

output "endpoint" {
  description = "The connection endpoint of the Redshift cluster, host:port"
  value       = aws_redshift_cluster.default.endpoint
}

output "dns_name" {
  description = "The DNS name of the Redshift cluster"
  value       = aws_redshift_cluster.default.dns_name
}

output "port" {
  description = "The port on which the cluster accepts connections"
  value       = aws_redshift_cluster.default.port
}

output "database_name" {
  description = "The name of the first database in the cluster"
  value       = aws_redshift_cluster.default.database_name
}

output "cluster_subnet_group_name" {
  description = "The name of the Redshift cluster subnet group"
  value       = aws_redshift_cluster.default.cluster_subnet_group_name
}

output "node_type" {
  description = "The node type of the Redshift cluster"
  value       = aws_redshift_cluster.default.node_type
}

output "number_of_nodes" {
  description = "The number of compute nodes in the Redshift cluster"
  value       = aws_redshift_cluster.default.number_of_nodes
}

output "publicly_accessible" {
  description = "Whether the Redshift cluster is publicly accessible"
  value       = aws_redshift_cluster.default.publicly_accessible
}

output "encrypted" {
  description = "Whether the Redshift cluster is encrypted at rest"
  value       = aws_redshift_cluster.default.encrypted
}
