resource "aws_security_group" "allow_ssh" {
  vpc_id      = ""
  name_prefix = "allow_ssh"
  description = "Allow ssh inbound traffic"

  ingress {
    from_port = 0
    to_port   = 50001
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  # outbound internet access
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  tags {
    Name = "front-gar - ssh allow sg"
  }
}

terraform {
  backend "consul" {
    address = "52.201.42.250:8500"
    path    = "hackathon/gar"
  }

  required_version = "> 0.7.0"
}

resource aws_instance "front-gar" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "m3.medium"

  security_groups = [
    "${aws_security_group.allow_ssh.name}",
  ]

  key_name = "${aws_key_pair.hackathon.key_name}"
}

resource "aws_key_pair" "hackathon" {
  public_key = "${file("garnaud.pub")}"
}

provider "aws" {
  region = "us-east-1"
}

provider "consul" {
  address    = "52.201.42.250:8500"
  datacenter = "dc1"
}

# Access a key in Consul
resource "consul_keys" "app" {
  key {
    path  = "coucou"
    value = "ami-1234"
  }

  provider = "consul"
}

resource "consul_service" "google" {
  address = "52.201.42.250"
  name    = "mygoogle"
  port    = 8200
  tags    = ["tag0", "tag1"]
}

variable "ami_search_path" {
  type    = "string"
  default = "ubuntu/images/ebs-ssd/ubuntu-xenial-16.04-amd64-server-*"
}

variable "cannonical_owner_id" {
  type    = "string"
  default = "099720109477"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"

    values = [
      "${var.ami_search_path}",
    ]
  }

  owners = [
    "${var.cannonical_owner_id}",
  ]
}
