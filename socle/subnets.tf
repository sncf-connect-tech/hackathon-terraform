resource "aws_subnet" "sas_securite" {
  vpc_id = "${aws_vpc.mainVPC.id}"
  cidr_block = "10.0.1.0/24"

  tags {
    Name = "Subnet sas securite"
    Owner = "Daniel Polombo"
  }
}

resource "aws_subnet" "zone_appli" {
  vpc_id = "${aws_vpc.mainVPC.id}"
  cidr_block = "10.0.2.0/24"

  tags {
    Name = "Subnet zone applicative"
    Owner = "Daniel Polombo"
  }
}

resource "aws_subnet" "zone_sgbd" {
  vpc_id = "${aws_vpc.mainVPC.id}"
  cidr_block = "10.0.3.0/24"

  tags {
    Name = "Subnet zone SGBD"
    Owner = "Daniel Polombo"
  }
}
