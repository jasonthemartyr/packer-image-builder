packer {
  required_plugins {
    amazon = {
      version = "~> 1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}


data "amazon-ami" "amazonlinux" {
  filters = var.aws_ami_filters
  most_recent = var.aws.most_recent
  owners      = var.aws.owners
  region      = var.aws.region
}

source "amazon-ebs" "amazon-linux" {
  ami_name                    = "github-linux-${local.timestamp}"
  associate_public_ip_address = true
  instance_type               = var.aws.instance_type
  iam_instance_profile        = var.aws.iam_instance_profile
  region                      = var.aws.region
  security_group_id           = var.aws.sg_id
  source_ami                  = data.amazon-ami.amazonlinux.id
  ssh_interface               = var.aws.ssh_interface
  ssh_username                = var.aws.ssh_username
  subnet_id                   = var.aws.subnet_id
  vpc_id                      = var.aws.vpc_id
  launch_block_device_mappings {
    device_name = var.aws.device_name
    volume_size = var.aws.volume_size
    volume_type = var.aws.volume_type
    delete_on_termination = var.aws.delete_on_termination
  }
  
}
