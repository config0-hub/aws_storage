# The module does not output number_of_nodes or publicly_accessible; those
# are the values this execgroup hands it. Its cluster_nodes list also counts
# the leader node of a multi-node cluster.

output "cluster_identifier" {
  description = "The cluster identifier of the Redshift cluster"
  value       = module.redshift.cluster_identifier
}

output "arn" {
  description = "The ARN of the Redshift cluster"
  value       = module.redshift.cluster_arn
}

output "cluster_namespace_arn" {
  description = "The namespace ARN of the Redshift cluster"
  value       = module.redshift.cluster_namespace_arn
}

output "endpoint" {
  description = "The connection endpoint of the Redshift cluster, host:port"
  value       = module.redshift.cluster_endpoint
}

output "dns_name" {
  description = "The DNS name of the Redshift cluster"
  value       = module.redshift.cluster_dns_name
}

output "port" {
  description = "The port on which the cluster accepts connections"
  value       = module.redshift.cluster_port
}

output "database_name" {
  description = "The name of the first database in the cluster"
  value       = module.redshift.cluster_database_name
}

output "cluster_subnet_group_name" {
  description = "The name of the Redshift cluster subnet group"
  value       = module.redshift.cluster_subnet_group_name
}

output "node_type" {
  description = "The node type of the Redshift cluster"
  value       = module.redshift.cluster_node_type
}

output "number_of_nodes" {
  description = "The number of compute nodes in the Redshift cluster"
  value       = var.number_of_nodes
}

output "publicly_accessible" {
  description = "Whether the Redshift cluster is publicly accessible"
  value       = var.publicly_accessible
}

output "encrypted" {
  description = "Whether the Redshift cluster is encrypted at rest"
  # AWS provider 6.x types the cluster's encrypted as a string ("true");
  # the output stays a bool, as it was on provider 5.x.
  value = tobool(module.redshift.cluster_encrypted)
}

output "master_user_secret_arn" {
  description = "The ARN of the Secrets Manager secret that holds the master user name and password"
  value       = module.redshift.master_password_secret_arn
}
