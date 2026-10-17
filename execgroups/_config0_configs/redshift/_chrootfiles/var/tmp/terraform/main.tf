# The Redshift cluster and its cluster subnet group, through the community module.
module "redshift" {
  source  = "terraform-aws-modules/redshift/aws"
  version = "7.1.1"

  cluster_identifier = var.redshift_name

  node_type       = var.node_type
  number_of_nodes = var.number_of_nodes
  port            = var.port

  database_name   = var.db_name
  master_username = var.master_username

  # Redshift makes the master password, keeps it in AWS Secrets Manager and
  # deletes it with the cluster. Config0 never makes, sees or stores it.
  # Rotation is what Redshift does by default for this secret, every 30 days:
  # the module's manage_master_password_rotation stays false and adds no
  # schedule.
  manage_master_password = true

  vpc_security_group_ids = var.security_group_ids

  # From the stack: the provider's own defaults differ by provider version,
  # and a destroy with skip_final_snapshot false needs a snapshot name.
  publicly_accessible = var.publicly_accessible
  encrypted           = var.encrypted
  skip_final_snapshot = var.skip_final_snapshot

  # As before the module: the stack's security group, the default parameter
  # group, and a maintenance window AWS picks. The module would otherwise
  # make a security group and a redshift-2.0 parameter group, and fix the
  # window at sat:10:00-sat:10:30. A null here is passed on as null.
  create_security_group        = false
  create_parameter_group       = false
  preferred_maintenance_window = null

  create_subnet_group      = true
  subnet_group_name        = var.cluster_subnet_name
  subnet_group_description = "Subnet group for Redshift cluster ${var.redshift_name}"
  subnet_ids               = var.subnet_ids

  tags = merge(
    var.cloud_tags,
    {
      Name    = var.redshift_name
      Product = "redshift"
    },
  )

  # The module tags the subnet group with tags merged with these, so the
  # group keeps its own Name.
  subnet_group_tags = {
    Name = var.cluster_subnet_name
  }
}
