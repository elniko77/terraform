# Configure the Libvirt provider
terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}
provider "libvirt" {
    uri = "qemu+ssh://nss@192.168.31.103/system"
}
resource "libvirt_volume" "ubuntu_jammy_server" {
    name   = "ubuntu_jammy_server"
    source = "/home/nss/ubuntu22.iso"
}
resource "libvirt_volume" "test_ubuntu" {
    name  = "test_ubuntu.qcow2"
    size = 10000000000
}
resource "libvirt_domain" "default" {
    name = "testvm-ubuntu1"
    vcpu = 2
    memory = 2048
    running = false 
    disk {
      volume_id = libvirt_volume.ubuntu_jammy_server.id
    }
    disk {
      volume_id = libvirt_volume.test_ubuntu.id
    }
    network_interface {
      bridge = "virbr0"
    }
}