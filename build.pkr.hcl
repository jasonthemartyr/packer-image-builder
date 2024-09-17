packer {
  required_plugins {
    ansible = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}


build {
  name = var.cloud_provider
  sources = ["source.${local.source_name}"]

  provisioner "shell-local" {
    inline = ["echo 'Building image for ${var.cloud_provider}'"]
  }

  provisioner "ansible" {
    playbook_file = local.playbook_file
    galaxy_file   =  local.galaxy_file
    use_proxy = false
    extra_arguments = var.ansible_extra_arguments
  }
  
}