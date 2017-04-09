#!/bin/bash

yum -y install mysql git
curl -s ftp://rpmfind.net/linux/dag/redhat/el5/en/x86_64/dag/RPMS/bbe-0.2.2-1.el5.rf.x86_64.rpm \
	-o bbe-0.2.2-1.el5.rf.x86_64.rpm
rpm -Uvh bbe-0.2.2-1.el5.rf.x86_64.rpm
git clone https://github.com/mitin001/pathfinder.git
