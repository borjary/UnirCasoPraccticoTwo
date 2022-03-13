variable "vm_size" {
  type = string
  description = "Tamaño de la máquina virtual"
  default = "Standard_B2s" # 4GB, 2 CPU 
}

variable "vms" {
  type = list(string)
  description = "Listado de maquinas virtuales a crear"
  default = ["master","worker01","worker02","nfs"]
}