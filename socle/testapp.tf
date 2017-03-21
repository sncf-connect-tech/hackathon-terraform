resource "aws_instance" "testapp" {
  ami                         = "ami-405f7226" 
  instance_type               = "m3.medium"
  associate_public_ip_address = false
  subnet_id                   = "${aws_subnet.zone_appli.id}"
  vpc_security_group_ids      = ["${aws_security_group.allow_ssh_from_bastion.id}"]
  key_name                    = "${aws_key_pair.hackathon.key_name}"

  tags {
    Name  = "testapp"
    Owner = "Daniel Polombo"
  }
}
