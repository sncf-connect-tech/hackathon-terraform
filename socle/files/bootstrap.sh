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
apt-get -y install squid 
/bin/sed -i 's,acl Safe_ports port 21,#acl Safe_ports port 21,g' /etc/squid/squid.conf
/bin/sed -i 's,acl Safe_ports port 70,#acl Safe_ports port 70,g' /etc/squid/squid.conf
/bin/sed -i 's,acl Safe_ports port 210,#acl Safe_ports port 210,g' /etc/squid/squid.conf
/bin/sed -i 's,acl Safe_ports port 1025-65535,#acl Safe_ports port 1025-65535,g' /etc/squid/squid.conf
/bin/sed -i 's,acl Safe_ports port 280,#acl Safe_ports port 280,g' /etc/squid/squid.conf
/bin/sed -i 's,acl Safe_ports port 488,#acl Safe_ports port 488,g' /etc/squid/squid.conf
/bin/sed -i 's,acl Safe_ports port 591,#acl Safe_ports port 591,g' /etc/squid/squid.conf
/bin/sed -i 's,acl Safe_ports port 777,#acl Safe_ports port 777,g' /etc/squid/squid.conf
/etc/init.d/squid restart
