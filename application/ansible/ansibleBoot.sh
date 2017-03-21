#!/bin/bash
# lance une commande sur le groupe des serveurs labellise apache dans le fichier host
#ansible apache -m ping --private-key ../tanguykey.pem 
#ansible-playbook apache.yml --private-key ../tanguykey.pem
# la cle est insere dans ansible.cfg
#ansible-playbook apache.yml 

#ansible apache -m ping --private-key ../ansible-keypair.pem
ansible-playbook apache.yml --private-key ../ansible-keypair.pem
ansible-playbook tomcat.yml --private-key ../ansible-keypair.pem



