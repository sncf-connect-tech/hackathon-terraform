resource "aws_instance" "apache" {
  #  ami = "${data.aws_ami.latest_ubuntu.id}"
  ami           = "ami-f4cc1de2"
  instance_type = "m3.medium"
  key_name      = "${data.terraform_remote_state.socle.socle_key_name}"
  count         = 2

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
  #  ami = "${data.aws_ami.latest_ubuntu.id}"
  ami           = "ami-f4cc1de2"
  instance_type = "m3.medium"
  key_name      = "${data.terraform_remote_state.socle.socle_key_name}"
  count         = 2

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
