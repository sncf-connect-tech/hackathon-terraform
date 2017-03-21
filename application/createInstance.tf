resource "aws_instance" "myvm" {
  ami           = "ami-0d729a60"
  instance_type = "t2.micro"

  tags {
	Name="myvm"
	Owner="prevellin"
  }
}


