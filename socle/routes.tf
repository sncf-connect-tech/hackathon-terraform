resource "aws_route_table" "internet_route" {
  vpc_id = "${aws_vpc.mainVPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw-mainVPC.id}"
  }

  tags {
    Name  = "Routage public"
    Owner = "Daniel Polombo"
  }
}

resource "aws_route_table_association" "routing_sas_securite" {
  route_table_id = "${aws_route_table.internet_route.id}"
  subnet_id      = "${aws_subnet.sas_securite.id}"
}

resource "aws_route_table_association" "routing_zone_transverse" {
  route_table_id = "${aws_route_table.internet_route.id}"
  subnet_id      = "${aws_subnet.zone_transverse.id}"
}


/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.mainVPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.gw.id}"
  }

  tags {
    Name = "${var.project_name} - private route table"
  }
}

resource "aws_route_table_association" "routing_zone_appli" {
  route_table_id = "${aws_route_table.private.id}"
  subnet_id      = "${aws_subnet.zone_appli.id}"
}

resource "aws_route_table_association" "routing_zone_sgbd" {
  route_table_id = "${aws_route_table.private.id}"
  subnet_id      = "${aws_subnet.zone_sgbd.id}"
}