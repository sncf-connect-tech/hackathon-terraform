
terraform {
  backend "consul" {
    address = "34.248.11.152:8500"
    path = "hackathon/gar"

  }
  required_version = "> 0.7.0"

}

resource aws_instance "front-gar" {
  ami = "${var.ami-201703-base}"
  instance_type = "m3.medium"
}

provider "aws" {
  region = "eu-west-1"
}

variable "ami-201703-base" {
  type = "string"
  default = "ami-7effd318"
}
