resource "aws_ebs_volume" "data-vol" {
  availability_zone = var.availability_zone
  size              = var.volume_size
  encrypted         = true
  type              = var.volume_type

  tags = merge(
    var.cloud_tags,
    {
      Name    = var.volume_name
      Product = "ebs"
    },
  )
}

