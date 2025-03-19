resource "aws_db_subnet_group" "default" {
  name       = var.db_subnet_name
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "default" {

  identifier = var.rds_name

  db_subnet_group_name   = aws_db_subnet_group.default.id
  vpc_security_group_ids = var.security_group_ids

  username = var.master_username
  password = var.master_password
  db_name  = var.db_name

  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  engine            = var.engine
  engine_version    = var.engine_version
  port              = var.port

  multi_az            = var.multi_az
  publicly_accessible = var.publicly_accessible
  storage_encrypted   = var.storage_encrypted
  storage_type        = var.storage_type

  # revisit if backup wanted
  #backup_retention_period = var.backup_retention_period
  #backup_window           = var.backup_window
  #maintenance_window      = var.maintenance_window

  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  skip_final_snapshot         = var.skip_final_snapshot

  tags = merge(
    var.cloud_tags,
    {
      Product = "rds"
    },
  )

}

output "db_subnet_group_name" {
  value = aws_db_instance.default.db_subnet_group_name
}

output "arn" {
  value = aws_db_instance.default.arn
}

output "publicly_accessible" {
  value = aws_db_instance.default.publicly_accessible
}

output "availability_zone" {
  value = aws_db_instance.default.availability_zone
}

output "allocated_storage" {
  value = aws_db_instance.default.allocated_storage
}

output "instance_class" {
  value = aws_db_instance.default.instance_class
}

output "performance_insights_enabled" {
  value = aws_db_instance.default.performance_insights_enabled
}

output "storage_type" {
  value = aws_db_instance.default.storage_type
}

output "multi_az" {
  value = aws_db_instance.default.multi_az
}

output "engine" {
  value = aws_db_instance.default.engine
}

output "engine_version" {
  value = aws_db_instance.default.engine_version
}