#!/bin/bash

yum -y install mysql git
curl -s ftp://rpmfind.net/linux/dag/redhat/el5/en/x86_64/dag/RPMS/bbe-0.2.2-1.el5.rf.x86_64.rpm \
	-o bbe-0.2.2-1.el5.rf.x86_64.rpm
rpm -Uvh bbe-0.2.2-1.el5.rf.x86_64.rpm
git clone https://github.com/mitin001/pathfinder.git
cd pathfinder/mysql
./get_edges.sh \
	https://dumps.wikimedia.org/enwiki/latest/enwiki-latest-page.sql.gz \
	https://dumps.wikimedia.org/enwiki/latest/enwiki-latest-pagelinks.sql.gz \
	> get_edges.log 2>&1
cd ..
zip untracked.zip $(git ls-files --others --exclude-standard)
aws s3 cp untracked.zip s3://pathfinder.mitinian.com/$(date +%s).zip
