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

output "ip" {
	value =["${aws_instance.apache.*.public_ip}"]
}

