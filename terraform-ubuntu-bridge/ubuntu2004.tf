terraform {
    required_version = ">= 0.13"
    required_providers {
        libvirt = {
            source  = "dmacvicar/libvirt"
            version = "0.6.10"
        }
    } 
}
provider "libvirt" {
   uri = "qemu+ssh://nss@192.168.1.50/system"

}

# create pool
resource "libvirt_pool" "ubuntu2004_2" {
 name = "ubuntu2004_2"
 type = "dir"
 path = "/var/lib/libvirt/images/libvirt_images/ubuntu_2004_2/"
}

resource "libvirt_volume" "ubuntu2004_2-qcow2" {
  name = "ubuntu2004_2.qcow2"
  pool = libvirt_pool.ubuntu2004_2.name
  source = "/home/nss/terraform/sources/ubuntu.qcow2"
  format = "qcow2"
}

resource "libvirt_cloudinit_disk" "commoninit" {
 name = "commoninit.iso"
 pool = libvirt_pool.ubuntu2004_2.name
 user_data = data.template_file.user_data.rendered
 network_config = data.template_file.cloudinit_network.rendered

}

data "template_file" "cloudinit_network" {
  template = file("${path.module}/network.cfg")
}

# read the configuration
data "template_file" "user_data" {
 template = file("${path.module}/cloud_init.cfg")
}




# Define KVM domain to create
resource "libvirt_domain" "ubuntu2004_2" {
  name   = "ubuntu2004_2"
  memory = "2048"
  vcpu   = 1
  qemu_agent = true

  cloudinit = libvirt_cloudinit_disk.commoninit.id

   network_interface {
    bridge = "br1"
    hostname = "ubuntu20042"
  } 

  disk {
    volume_id = "${libvirt_volume.ubuntu2004_2-qcow2.id}"
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "vnc"
    listen_type = "address"
    autoport = true
  }
}
