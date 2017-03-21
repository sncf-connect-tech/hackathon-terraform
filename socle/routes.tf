resource "aws_route_table" "internet_route" {
  vpc_id = "${aws_vpc.mainVPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw-mainVPC.id}"
  }

  tags {
    Name = "Routage public"
    Owner = "Daniel Polombo"
  }
}

resource "aws_route_table_association" "public_routing" {
  route_table_id = "${aws_route_table.internet_route.id}"
  subnet_id = "${aws_subnet.sas_securite.id}"
}
