resource "aws_key_pair" "ansiblekey" {
  key_name   = "${var.user}AnsibleDeployementKey"
  public_key = "${var.ansiblePublicSsh}"
}

