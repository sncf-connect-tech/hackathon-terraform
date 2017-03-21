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
