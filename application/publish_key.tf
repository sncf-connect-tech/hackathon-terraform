resource "aws_key_pair" "ansiblekey" {
  key_name   = "AnsibleDeployementKey"
  public_key = "${file("ansible.public.ssh")}"
}
