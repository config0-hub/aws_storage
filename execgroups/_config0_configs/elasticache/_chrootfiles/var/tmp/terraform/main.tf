resource "aws_elasticache_subnet_group" "default" {
  name        = var.cache_subnet_name
  subnet_ids  = var.subnet_ids
  description = "Subnet group for ElastiCache replication group ${var.cache_name}"

  tags = merge(
    var.cloud_tags,
    {
      Name    = var.cache_subnet_name
      Product = "elasticache"
    },
  )
}

# A user group needs a user named "default". This one replaces the
# AWS-managed open-access default user and is disabled ("off"), the form
# "Applying RBAC to a cache" documents
# (https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/Clusters.RBAC.html).
resource "aws_elasticache_user" "default" {
  user_id       = "${var.cache_name}-default"
  user_name     = "default"
  engine        = var.engine
  access_string = "off +get ~keys*"

  authentication_mode {
    type      = "password"
    passwords = [var.default_user_password]
  }

  tags = merge(
    var.cloud_tags,
    {
      Name    = "${var.cache_name}-default"
      Product = "elasticache"
    },
  )
}

resource "aws_elasticache_user_group" "default" {
  user_group_id = var.user_group_id
  engine        = var.engine
  user_ids      = [aws_elasticache_user.default.user_id]

  # an elasticache_access grant adds its own user to this group through an
  # aws_elasticache_user_group_association; ignoring user_ids keeps a re-apply
  # of this stack from removing that user
  lifecycle {
    ignore_changes = [user_ids]
  }

  tags = merge(
    var.cloud_tags,
    {
      Name    = var.user_group_id
      Product = "elasticache"
    },
  )
}

# cluster mode off: one node group (num_node_groups unset), num_cache_clusters
# nodes in it
resource "aws_elasticache_replication_group" "default" {
  replication_group_id = var.cache_name
  description          = "ElastiCache replication group ${var.cache_name}"

  engine             = var.engine
  engine_version     = var.engine_version
  node_type          = var.node_type
  num_cache_clusters = var.num_cache_clusters
  port               = var.port

  subnet_group_name  = aws_elasticache_subnet_group.default.name
  security_group_ids = var.security_group_ids

  automatic_failover_enabled = var.num_cache_clusters > 1
  multi_az_enabled           = false

  # RBAC user groups and IAM authentication need encryption in transit
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  user_group_ids             = [aws_elasticache_user_group.default.user_group_id]

  apply_immediately = true

  tags = merge(
    var.cloud_tags,
    {
      Name    = var.cache_name
      Product = "elasticache"
    },
  )
}
