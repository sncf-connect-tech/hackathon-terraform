resource "aws_instance" "apache" {
  ami = "${data.aws_ami.latest_ubuntu.id}"

  #ami           = "ami-f4cc1de2"
  instance_type     = "m3.medium"
  key_name          = "${data.terraform_remote_state.socle.socle_key_name}"
  count             = 2

  tags {
    Name  = "apache"
    Owner = "prevellin"
  }

  subnet_id = "${data.terraform_remote_state.socle.socle_subnet_sas_securite_id}"

  vpc_security_group_ids = [
    "${data.terraform_remote_state.socle.socle_security_group_allow_ssh_from_bastion_id}",
    "${data.terraform_remote_state.socle.socle_security_group_sg_web_id}",
  ]
}

resource "aws_instance" "tomcat" {
  ami = "ami-f4e454e2"

  #ami           = "ami-f4cc1de2"
  instance_type     = "m3.medium"
  key_name          = "${data.terraform_remote_state.socle.socle_key_name}"
  count             = 2

  tags {
    Name  = "tomcat"
    Owner = "prevellin"
  }

  subnet_id = "${data.terraform_remote_state.socle.socle_subnet_zone_appli_id}"

  vpc_security_group_ids = [
    "${data.terraform_remote_state.socle.socle_security_group_allow_ssh_from_bastion_id}",
    "${data.terraform_remote_state.socle.socle_security_group_sg_app_id}",
  ]
}


resource "aws_elb" "hackathon" {

  # refactor this
  subnets = ["${data.terraform_remote_state.socle.socle_subnet_sas_securite_id}"]
  security_groups = [
    "${data.terraform_remote_state.socle.socle_security_group_allow_ssh_from_bastion_id}",
    "${data.terraform_remote_state.socle.socle_security_group_sg_web_id}",
  ]

  listener {
    instance_port = 8080
    instance_protocol = "tcp"
    lb_port = 80
    lb_protocol = "tcp"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 5
    target = "TCP:8080"
    interval = 5
    timeout = 4
  }

  instances = ["${aws_instance.tomcat.*.id}"]

  tags = {
    Name  = "elb"
    Owner = "prevellin"
  }
}

data "aws_route53_zone" "myzone" {
  name = "vsct-hackathon.com"
}

resource "aws_route53_record" "tfdevoxx" {
  zone_id = "${data.aws_route53_zone.myzone.id}"
  name = "www"
  type = "A"

  alias {
    name = "${aws_elb.hackathon.dns_name}"
    zone_id = "${aws_elb.hackathon.zone_id}"
    evaluate_target_health = true
  }
}

output "ip_apache" {
  value = [
    "${aws_instance.apache.*.private_ip}",
  ]
}

output "ip_tomcat" {
  value = [
    "${aws_instance.tomcat.*.private_ip}",
  ]
}

data "template_file" "inventory" {
  template = "${file("ansible/hosts.ansible.tpl")}"

  vars {
    list_apache_node = "${join("\n",formatlist("%s ansible_ssh_user=ubuntu",aws_instance.apache.*.private_ip))}"
    list_tomcat_node = "${join("\n",formatlist("%s ansible_ssh_user=ubuntu",aws_instance.tomcat.*.private_ip))}"
  }
}

resource "null_resource" "inventories" {
  provisioner "local-exec" {
    command = "echo '${data.template_file.inventory.rendered}' > ansible/hosts.ansible"
  }
}
