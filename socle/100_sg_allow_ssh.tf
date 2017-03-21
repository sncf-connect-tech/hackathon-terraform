resource "aws_security_group" "allow_ssh" {
  vpc_id      = "${aws_vpc.mainVPC.id}"
  name_prefix = "allow_ssh"
  description = "Allow ssh inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.project_name} - ssh allow sg"
  }
}