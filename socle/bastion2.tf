data "template_file" "bootstrap2" {
  template = "${file("files/bootstrap.sh")}"
}

resource "aws_instance" "bastion2" {
  ami                         = "ami-405f7226" 
  associate_public_ip_address = true
  instance_type               = "m3.medium"
  subnet_id                   = "${aws_subnet.zone_transverse.id}"
  vpc_security_group_ids      = ["${aws_security_group.sg_bastion.id}"]
  key_name                    = "${aws_key_pair.hackathon.key_name}"
  user_data		      = "${data.template_file.bootstrap.rendered}"

  tags {
    Name  = "bastion2"
    Owner = "nikko"
  }
}
