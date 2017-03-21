resource "aws_instance" "bastion" {
  ami                         = "ami-405f7226" 
  associate_public_ip_address = true
  instance_type               = "m3.medium"
  subnet_id                   = "${aws_subnet.zone_transverse.id}"
  vpc_security_group_ids      = ["${aws_security_group.allow_ssh_from_any.id}"]
  key_name                    = "${aws_key_pair.hackathon.key_name}"

  tags {
    Name  = "bastion"
    Owner = "nikko"
  }
}
