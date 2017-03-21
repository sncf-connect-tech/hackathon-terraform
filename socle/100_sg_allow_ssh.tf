resource "aws_security_group" "allow_ssh_from_any" {
  vpc_id      = "${aws_vpc.mainVPC.id}"
  name_prefix = "allow_ssh_from_any"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name  = "${var.project_name} - allow_ssh_from_any"
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
    security_groups = ["${aws_security_group.allow_ssh_from_any.id}"]
  }

  tags {
    Name  = "${var.project_name} - allow_ssh_from_bastion"
    Owner = "ylorenzati"
  }
}

resource "aws_security_group" "allow_web_from_any" {
  vpc_id      = "${aws_vpc.mainVPC.id}"
  name_prefix = "allow_web_from_any"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name  = "${var.project_name} -allow_web_from_any"
    Owner = "ylorenzati"
  }
}

resource "aws_security_group" "allow_appli_from_web" {
  vpc_id      = "${aws_vpc.mainVPC.id}"
  name_prefix = "allow_appli_from_web"

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${aws_security_group.allow_web_from_any.id}"]
  }

  tags {
    Name  = "${var.project_name} - allow_appli_from_web"
    Owner = "ylorenzati"
  }
}

resource "aws_security_group" "allow_sgbd_from_appli" {
  vpc_id      = "${aws_vpc.mainVPC.id}"
  name_prefix = "allow_sgbd_from_appli"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.allow_appli_from_web.id}"]
  }

  tags {
    Name  = "${var.project_name} - allow_sgbd_from_appli"
    Owner = "ylorenzati"
  }
}
