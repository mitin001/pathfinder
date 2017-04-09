#!/bin/bash

url=$1 # https://dumps.wikimedia.org/enwiki/latest/enwiki-latest-page.sql.gz
gz=${url##*/} # enwiki-latest-page.sql.gz
sql=${gz%%.gz*} # enwiki-latest-page.sql
replace="replace-$sql" # replace-enwiki-latest-page.sql

# download data
curl $url -o $gz
echo $(date +%s) Downloaded $url >> debugger.log

# inflate downloaded data
gunzip $gz # removes enwiki-latest-page.sql.gz, makes enwiki-latest-page.sql
echo $(date +%s) Inflated $gz >> debugger.log

# extract the insert statements and convert them to replace statements
egrep "^INSERT INTO" $sql \ # find lines that beging with INSERT INTO keywords (SQL)
	| bbe -e 's/^INSERT INTO/REPLACE INTO/' \ # replace them with REPLACE INTO keywords
	> $replace # replace-enwiki-latest-page.sql
rm -f $sql # remove enwiki-latest-page.sql because we have replace-enwiki-latest-page.sql
echo $(date +%s) Parsed $sql >> debugger.log

echo $replace # output: location of replace-enwiki-latest-page.sql
