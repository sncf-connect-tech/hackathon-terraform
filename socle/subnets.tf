resource "aws_subnet" "sas_securite" {
  vpc_id     = "${aws_vpc.mainVPC.id}"
  cidr_block = "${cidrsubnet(aws_vpc.mainVPC.cidr_block, 8, 1)}"

  tags {
    Name  = "Subnet sas securite"
    Owner = "Daniel Polombo"
  }

  availability_zone = "${var.default_az}"
}

resource "aws_subnet" "zone_appli" {
  vpc_id     = "${aws_vpc.mainVPC.id}"
  cidr_block = "${cidrsubnet(aws_vpc.mainVPC.cidr_block, 8, 2)}"

  tags {
    Name  = "Subnet zone applicative"
    Owner = "Daniel Polombo"
  }

  availability_zone = "${var.default_az}"
}

resource "aws_subnet" "zone_sgbd" {
  vpc_id     = "${aws_vpc.mainVPC.id}"
  cidr_block = "${cidrsubnet(aws_vpc.mainVPC.cidr_block, 8, 3)}"

  tags {
    Name  = "Subnet zone SGBD"
    Owner = "Daniel Polombo"
  }

  availability_zone = "${var.default_az}"
}

resource "aws_subnet" "zone_transverse" {
  vpc_id     = "${aws_vpc.mainVPC.id}"
  cidr_block = "${cidrsubnet(aws_vpc.mainVPC.cidr_block, 8, 4)}"

  tags {
    Name  = "Subnet zone transverse"
    Owner = "Daniel Polombo"
  }

  availability_zone = "${var.default_az}"
}

output "socle_subnet_zone_appli_id" {
  value = "${aws_subnet.zone_appli.id}"
}

output "socle_subnet_sas_securite_id" {
  value = "${aws_subnet.sas_securite.id}"
}
