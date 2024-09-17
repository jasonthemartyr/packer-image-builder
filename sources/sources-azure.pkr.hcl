packer {
  required_plugins {
    azure = {
      version = "~> 2"
      source  = "github.com/hashicorp/azure"
    }
  }
}


source "azure-arm" "ubuntu" {
  ssh_username                = var.azure.ssh_username
  location                          =  var.azure.location
  managed_image_name                = "github-${var.azure.image_name}-${local.version}"
  managed_image_resource_group_name = var.azure.managed_image_resource_group_name
  os_type                           = var.azure.os_type
  os_disk_size_gb                   = var.azure.os_disk_size_gb

  image_publisher = var.azure_image_settings.image_publisher
  image_offer     = var.azure_image_settings.image_offer
  image_sku       = var.azure_image_settings.image_sku

  shared_image_gallery {
    gallery_name         = var.azure_shared_image_gallery.gallery_name
    image_name           = var.azure_shared_image_gallery.image_name
    resource_group       = var.azure_shared_image_gallery.resource_group
    subscription         = var.azure_shared_image_gallery.subscription
  }

  shared_image_gallery_destination {
    gallery_name         = var.azure.gallery_name
    image_name           = var.azure.image_name
    image_version        = local.version
    replication_regions  = var.azure.replication_regions
    resource_group       = var.azure.resource_group
    storage_account_type = var.azure.storage_account_type
    subscription         = var.azure.subscription
  }
  user_assigned_managed_identities = var.azure.user_assigned_managed_identities
  virtual_network_name             = var.azure.virtual_network_name
  virtual_network_subnet_name      = var.azure.virtual_network_subnet_name
  virtual_network_resource_group_name = var.azure.virtual_network_resource_group_name
  vm_size                          = var.azure.vm_size

  use_azure_cli_auth = var.azure.use_azure_cli_auth
  subscription_id = var.azure.subscription_id
  async_resourcegroup_delete = true


}