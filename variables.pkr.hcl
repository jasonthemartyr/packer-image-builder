locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
  # source_name = var.cloud_provider == "aws" ? "amazon-ebs.amazon-linux" : (var.cloud_provider == "azure" ? "azure-arm.ubuntu" : "")
  source_name = var.cloud_provider == "aws" ? "amazon-ebs.ubuntu" : "azure-arm.ubuntu"

  playbook_file = var.cloud_provider == "aws" ? "ansible/aws.yml" : "ansible/azure.yml"
  galaxy_file = var.cloud_provider == "aws" ? "" : "ansible/azure-requirements.yaml"
  version = formatdate("YYMM.DD.hDms", timestamp())
  use_aws = var.cloud_provider == "aws"
}

variable "cloud_provider" {
  type    = string
  default = env("CLOUD_PROVIDER")
}

variable "aws" {
  type = object({
    owners = list(string)
    most_recent = bool
    instance_type = string
    region        = string
    sg_id         = string
    vpc_id = string
    subnet_id = string
    ssh_interface = string
    ssh_username = string
    iam_instance_profile = string
    device_name = string
    volume_size = number
    volume_type = string
    delete_on_termination = bool
  })
}

variable "aws_ami_filters" {
  type = object({
    name                = string
    root-device-type    = string
    virtualization-type = string
  })
  default = {
    name                = "al2023-ami-2023*-x86_64"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  description = "Filters for selecting the Amazon Linux 2023 AMI"
}


variable "azure" {
  type = object({
    ssh_username = string
    location        = string
    managed_image_resource_group_name         = string
    os_type = string
    os_disk_size_gb = number
    gallery_name = string
    image_name           = string
    replication_regions = list(string)
    resource_group       = string
    storage_account_type = string
    subscription         = string
    user_assigned_managed_identities = list(string)
    virtual_network_name = string
    virtual_network_subnet_name = string
    virtual_network_resource_group_name = string
    vm_size = string
    use_azure_cli_auth = bool
    subscription_id = string
    async_resourcegroup_delete = bool
  })
}

variable "azure_image_settings"{
  type = object({
    image_publisher = string
    image_offer = string
    image_sku = string
  })
}

# For use with incremental Azure image builds
variable "azure_shared_image_gallery" {
 type = object({
  gallery_name = string
  image_name = string
  resource_group = string
  subscription = string
 })
  default = {
    gallery_name = ""
    image_name = ""
    resource_group = ""
    subscription = ""
  }

}

variable "ansible_extra_arguments" {
  type = list(string)
  default = [
      # "-vvv",
      "--extra-vars", "ansible_python_interpreter=/usr/bin/python3",
      "--extra-vars", "ansible_proxy_key_type=rsa"
  ]
}