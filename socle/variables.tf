variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "eu-west-1"
}

variable "ssh_key_name" {
  default = "ssh/idrsa"
}

variable "ssh_public_key" {
  default = "ssh/idrsa.pub"
}
