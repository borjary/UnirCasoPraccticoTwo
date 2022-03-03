variable "location" {
  type = string
  description = "Región de Azure donde crearemos la infraestructura"
  default = "West Europe"
}

variable "vm_size" {
  type = string
  description = "Tamaño de la máquina virtual"
  default = "Standard_D1_v2" # 3.5 GB, 1 CPU 
}

variable "storage_account" {
  type = string
  description = "Nombre para la storage account"
  default = "storageaccborjary"
}

variable "public_key_path" {
  type = string
  description = "Ruta para la clave pública de acceso a las instancias"
  default = "C:/ssh/public" # o la ruta correspondiente
}

variable "ssh_user" {
  type = string
  description = "Usuario para hacer ssh"
  default = "adminuser"
}

variable "vms" {
  type = list(string)
  description = "Listado de maquinas virtuales a crear"
  default = ["master", "worker01","worker02","nfs"]
}