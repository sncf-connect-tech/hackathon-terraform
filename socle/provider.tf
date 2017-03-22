terraform {
  backend "consul" {
    address = "34.248.11.152:8500"
    path    = "hackathon/socle"
  }
}

provider "aws" {
  region = "${var.region}"
}

resource "aws_key_pair" "hackathon" {
  public_key = "${file("ssh/idrsa.pub")}"
}

output "socle_key_name" {
  value ="${aws_key_pair.hackathon.key_name}"
}
