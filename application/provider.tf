terraform {
  backend "consul" {
    address = "34.248.11.152:8500"
    path    = "hackathon/application"
  }
}

data "terraform_remote_state" "socle" {
  backend = "consul"
  config {
    address = "34.248.11.152:8500"
    path    = "hackathon/socle"
  }
}

provider "aws" {
  region = "${var.region}"
  profile = "default"
}
