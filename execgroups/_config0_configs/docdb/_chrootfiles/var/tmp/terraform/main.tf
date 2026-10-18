resource "aws_docdb_subnet_group" "default" {
  name        = var.db_subnet_name
  subnet_ids  = var.subnet_ids
  description = "Subnet group for DocumentDB cluster ${var.docdb_name}"

  tags = merge(
    var.cloud_tags,
    {
      Name    = var.db_subnet_name
      Product = "docdb"
    },
  )
}

# TLS is on: no db_cluster_parameter_group_name is set, so the cluster takes
# the engine's default parameter group, which has tls enabled.
resource "aws_docdb_cluster" "default" {
  cluster_identifier = var.docdb_name

  engine         = "docdb"
  engine_version = var.engine_version
  port           = var.port

  db_subnet_group_name   = aws_docdb_subnet_group.default.name
  vpc_security_group_ids = var.security_group_ids

  master_username = var.master_username

  # DocumentDB makes the master password, keeps it in AWS Secrets Manager and
  # deletes it with the cluster. Config0 never makes, sees or stores it.
  # DocumentDB rotates it every seven days by default; nothing here adds a
  # schedule.
  manage_master_user_password = true

  storage_encrypted = var.storage_encrypted

  # From the stack: the provider's own default (skip_final_snapshot = false)
  # makes every destroy need a final snapshot name.
  skip_final_snapshot = var.skip_final_snapshot
  deletion_protection = var.deletion_protection

  tags = merge(
    var.cloud_tags,
    {
      Name    = var.docdb_name
      Product = "docdb"
    },
  )
}

resource "aws_docdb_cluster_instance" "default" {
  identifier         = "${var.docdb_name}-1"
  cluster_identifier = aws_docdb_cluster.default.id
  instance_class     = var.instance_class

  tags = merge(
    var.cloud_tags,
    {
      Name    = "${var.docdb_name}-1"
      Product = "docdb"
    },
  )
}
