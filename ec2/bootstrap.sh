#!/bin/bash

yum -y install mysql
curl -s ftp://rpmfind.net/linux/dag/redhat/el5/en/x86_64/dag/RPMS/bbe-0.2.2-1.el5.rf.x86_64.rpm \
	-o bbe-0.2.2-1.el5.rf.x86_64.rpm
rpm -Uvh bbe-0.2.2-1.el5.rf.x86_64.rpm
