resource "aws_security_group" "sg_bastion" {
  vpc_id      = "${aws_vpc.mainVPC.id}"
  name_prefix = "sg_bastion"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["${aws_vpc.mainVPC.cidr_block}"]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags {
    Name  = "${var.project_name} - sg_bastion"
    Owner = "ylorenzati"
  }
}

resource "aws_security_group" "allow_ssh_from_bastion" {
  vpc_id      = "${aws_vpc.mainVPC.id}"
  name_prefix = "allow_ssh_from_bastion"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.sg_bastion.id}"]
  }

  tags {
    Name  = "${var.project_name} - allow_ssh_from_bastion"
    Owner = "ylorenzati"
  }
}

resource "aws_security_group" "sg_web" {
  vpc_id      = "${aws_vpc.mainVPC.id}"
  name_prefix = "sg_web"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = -1
    cidr_blocks = ["${aws_vpc.mainVPC.cidr_block}"]
  }

  tags {
    Name  = "${var.project_name} - sg_web"
    Owner = "ylorenzati"
  }
}

resource "aws_security_group" "sg_app" {
  vpc_id      = "${aws_vpc.mainVPC.id}"
  name_prefix = "sg_sgbd"

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${aws_security_group.sg_web.id}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = -1
    cidr_blocks = ["${aws_vpc.mainVPC.cidr_block}"]
  }

  tags {
    Name  = "${var.project_name} - sg_app"
    Owner = "ylorenzati"
  }
}

resource "aws_security_group" "sg_sgbd" {
  vpc_id      = "${aws_vpc.mainVPC.id}"
  name_prefix = "sg_sgbd"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.sg_app.id}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = -1
    cidr_blocks = ["${aws_vpc.mainVPC.cidr_block}"]
  }

  tags {
    Name  = "${var.project_name} - sg_sgbd"
    Owner = "ylorenzati"
  }
}
