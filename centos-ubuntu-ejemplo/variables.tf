variable "hosts" {
  type = number
  default = 2
}
variable "interface" {
  type = string
  default = "ens01"
}
variable "memory" {
  type = string
  default = "1024"
}
variable "vcpu" {
  type = number
  default = 1
}
variable "distros" {
  type = list
  default = ["ubuntu", "centos"]
}
variable "ips" {
  type = list
  default = ["192.168.122.11", "192.168.122.22"]
}
variable "macs" {
  type = list
  default = ["52:54:00:50:99:c5", "52:54:00:0e:87:be"]
}
