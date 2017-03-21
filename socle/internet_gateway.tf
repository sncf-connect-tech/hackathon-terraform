resource "aws_internet_gateway" "gw-mainVPC" {
  vpc_id = "${aws_vpc.mainVPC.id}"

  tags {
    Name = "internet-gw"
    Owner = "tfe"
  }
}
