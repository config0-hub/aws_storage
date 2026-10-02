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
  master_password = var.master_password

  storage_encrypted   = var.storage_encrypted
  skip_final_snapshot = var.skip_final_snapshot

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
