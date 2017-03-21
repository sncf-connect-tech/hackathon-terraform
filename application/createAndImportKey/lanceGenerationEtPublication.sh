#!/bin/bash
openssl genrsa -out ansible-keypair.pem 2048
openssl rsa -in ansible-keypair.pem -outform PEM -pubout -out ansible.public.pem
ssh-keygen -f ansible.public.pem -i -m PKCS8 > ansible.public.ssh

export TF_VAR_ansiblePublicSsh=`cat ansible.public.ssh`
export TF_VAR_user=$USER

terraform apply


