# fetch the latest ami

data "aws_ami" "image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# AWS Launch Template

resource "aws_launch_template" "instances_template" {
  name        = "${var.env}-instances-template"
  description = "Launch template used to provision EC2 instances for the environment"

  image_id      = data.aws_ami.image.id
  instance_type = var.instance_type_template

  key_name = var.key_name

  iam_instance_profile {
    name = var.instance_profile_name
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }
  monitoring {
    enabled = true
  }
  user_data = var.user_data

  vpc_security_group_ids = var.sg_ids

  update_default_version = true

  # Tags applied to instances launched from this template
  # tag_specification
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "${var.env}-app-server"
      Environment = var.env
    }
  }

  # Tags for volumes created with the instances
  tag_specifications {
    resource_type = "volume"
    tags = {
      Name        = "app-server-volume"
      Environment = var.env
    }
  }

  tags = {
    Name        = "${var.env}-app-main-template"
    Environment = var.env
  }
}
