#!/bin/bash
#
set -x

# Variables
LOGFILE=/var/log/user-data.log

# Make sure we have a log for the bootstrap process
test -d $LOGDIR || mkdir -p $LOGDIR
exec > >(tee -a $LOGFILE)
exec 2>&1

mkdir -p /home/admsys/.ssh
useradd admsys
cp -r /home/ubuntu/.ssh/* /home/admsys/.ssh/
chmod 644 /home/admsys/.ssh/authorized_keys
apt-get install ansible -y
mv /etc/ansible /etc/ansible.orig
apt-get install git -y 
mkdir -p /appl/git/
cd /appl/git/
git clone https://github.com/voyages-sncf-technologies/hackathon-terraform.git
ln -s /appl/git/hackathon-terraform/application/ansible /etc/ansible
