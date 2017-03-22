resource "aws_instance" "bastion2" {
  ami                         = "${data.aws_ami.latest_ubuntu}"
  associate_public_ip_address = true
  instance_type               = "m3.medium"
  subnet_id                   = "${aws_subnet.zone_transverse.id}"
  vpc_security_group_ids      = ["${aws_security_group.sg_bastion.id}"]
  key_name                    = "${aws_key_pair.hackathon.key_name}"

  tags {
    Name  = "bastion2"
    Owner = "nikko"
  }
}
