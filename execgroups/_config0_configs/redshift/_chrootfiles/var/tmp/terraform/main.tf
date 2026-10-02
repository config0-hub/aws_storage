resource "aws_redshift_subnet_group" "default" {
  name        = var.cluster_subnet_name
  subnet_ids  = var.subnet_ids
  description = "Subnet group for Redshift cluster ${var.redshift_name}"

  tags = merge(
    var.cloud_tags,
    {
      Name    = var.cluster_subnet_name
      Product = "redshift"
    },
  )
}

resource "aws_redshift_cluster" "default" {
  cluster_identifier = var.redshift_name

  cluster_subnet_group_name = aws_redshift_subnet_group.default.name
  vpc_security_group_ids    = var.security_group_ids

  master_username = var.master_username
  master_password = var.master_password
  database_name   = var.db_name

  node_type       = var.node_type
  number_of_nodes = var.number_of_nodes
  cluster_type    = var.number_of_nodes > 1 ? "multi-node" : "single-node"
  port            = var.port

  # set explicitly: the aws provider defaults publicly_accessible to true
  # and skip_final_snapshot to false (a destroy would then fail)
  publicly_accessible = var.publicly_accessible
  encrypted           = var.encrypted
  skip_final_snapshot = var.skip_final_snapshot

  tags = merge(
    var.cloud_tags,
    {
      Name    = var.redshift_name
      Product = "redshift"
    },
  )
}
