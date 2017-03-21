data "aws_ami" "latest_amlinux" {
	most_recent = true

   filter {
	name = "virtualization-type"
	values = ["hvm"]
   }

   filter {
	name = "name"
	values = ["ADOPC-UBUNTU-16-*"]
   }
}

resource "aws_instance" "bastion" {
	ami = "${data.aws_ami.latest_amlinux.id}"
	associate_public_ip_address = "1"
	instance_type = "t2.micro"	
	subnet_id = "${aws_subnet.zone_transverse.id}"
	vpc_security_group_ids = ["${aws_security_group.allow_ssh_from_any.id}"]
	key_name = "${aws_key_pair.hackathon.public_key}"
	tags {
    		Name = "bastion"
    		Owner = "nikko"
  	}

}
