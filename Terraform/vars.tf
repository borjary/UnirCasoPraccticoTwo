variable "vm_size" {
  type = list(string)
  description = "Tamaño de la máquina virtual"
  default =  ["Standard_D2s_v3","Standard_D1_v2","Standard_D1_v2"] 
}

variable "vms" {
  type = list(string)
  description = "Listado de maquinas virtuales a crear"
  default = ["master","worker","nfs"]
}