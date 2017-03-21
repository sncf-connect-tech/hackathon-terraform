resource "aws_vpc" "mainVPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "dedicated"

  tags {
    Name = "VPC-Hackaton"
    Owner = "nikko"
  }
}
