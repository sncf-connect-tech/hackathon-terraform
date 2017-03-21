resource "aws_subnet" "sas_securite" {
  vpc_id = "${aws_vpc.mainVPC.id}"
  cidr_block = "${cidrsubnet(aws_vpc.mainVPC.cidr_block, 8, 1)}"

  tags {
    Name = "Subnet sas securite"
    Owner = "Daniel Polombo"
  }
}

resource "aws_subnet" "zone_appli" {
  vpc_id = "${aws_vpc.mainVPC.id}"
  cidr_block = "${cidrsubnet(aws_vpc.mainVPC.cidr_block, 8, 2)}"

  tags {
    Name = "Subnet zone applicative"
    Owner = "Daniel Polombo"
  }
}

resource "aws_subnet" "zone_sgbd" {
  vpc_id = "${aws_vpc.mainVPC.id}"
  cidr_block = "${cidrsubnet(aws_vpc.mainVPC.cidr_block, 8, 3)}"

  tags {
    Name = "Subnet zone SGBD"
    Owner = "Daniel Polombo"
  }
}
