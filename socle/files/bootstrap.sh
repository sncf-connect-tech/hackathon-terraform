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
useradd -s /bin/bash admsys
cp -r /home/ubuntu/.ssh/* /home/admsys/.ssh/
cp -r /home/ubuntu/.bashrc /home/admsys/
cp -r /home/ubuntu/.profile /home/admsys/
chmod 644 /home/admsys/.ssh/authorized_keys
apt-get -q update
apt-get -qy install python
