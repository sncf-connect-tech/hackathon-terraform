resource "aws_instance" "apache" {
  ami           = "ami-0d729a60"
  instance_type = "t2.micro"
  key_name = "AnsibleDeployementKey"
  count=2
  tags {
	Name="apache"
	Owner="prevellin"
  }
}

resource "aws_instance" "tomcat" {
  ami           = "ami-0d729a60"
  instance_type = "t2.micro"
  key_name = "AnsibleDeployementKey"
  count=2
  tags {
        Name="tomcat"
        Owner="prevellin"
  }
}

output "ip_apache" {
	value =["${aws_instance.apache.*.public_ip}"]
}
output "ip_tomcat" {
        value =["${aws_instance.tomcat.*.public_ip}"]
}


data "template_file" "inventory" {
    template = "${file("ansible/hosts.ansible.tpl")}"

    vars {
        list_apache_node = "${join("\n",formatlist("%s ansible_ssh_user=ubuntu",aws_instance.apache.*.public_ip))}"
        list_tomcat_node = "${join("\n",formatlist("%s ansible_ssh_user=ubuntu",aws_instance.tomcat.*.public_ip))}"
    }
}

resource "null_resource" "inventories" {
  provisioner "local-exec" {
      command = "echo '${data.template_file.inventory.rendered}' > ansible/hosts.ansible"
  }
}
