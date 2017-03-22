data "template_file" "bootstrap_shinken" {
  template = "${file("files/bootstrap_shinken.sh")}"
}

resource "aws_instance" "shinken" {
  ami                         = "ami-405f7226" 
  associate_public_ip_address = true
  instance_type               = "m3.medium"
  subnet_id                   = "${aws_subnet.zone_transverse.id}"
  vpc_security_group_ids      = ["${aws_security_group.sg_bastion.id}"]
  key_name                    = "${aws_key_pair.hackathon.key_name}"
  user_data		      = "${data.template_file.bootstrap_shinken.rendered}"

  tags {
    Name  = "shinken"
    Owner = "tpx"
  }
}
