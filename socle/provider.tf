terraform {
  backend "consul" {
    address = "34.248.11.152:8500"
    path    = "hackathon/socle"
  }
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_key_pair" "tfdevoxx" {
  public_key = "${file("ssh/idrsa.pub")}"
}