#!/bin/bash

page_url=$1 # https://dumps.wikimedia.org/enwiki/latest/enwiki-latest-page.sql.gz
pagelinks_url=$2 # https://dumps.wikimedia.org/enwiki/latest/enwiki-latest-pagelinks.sql.gz
cnf=../ribosomes.cnf

# create tables
cd tables
mysql --defaults-extra-file=$cnf < page.sql
mysql --defaults-extra-file=$cnf < page_dflt_ns.sql
mysql --defaults-extra-file=$cnf < pagelinks.sql
mysql --defaults-extra-file=$cnf < edges.sql

# create triggers
cd ../triggers
mysql --defaults-extra-file=$cnf --delimiter=";;" < page_before_insert.sql
mysql --defaults-extra-file=$cnf --delimiter=";;" < pagelinks_before_insert.sql

# get page content
cd ../content
page_content=$(../get_content.sh $page_url)
mysql --defaults-extra-file=$cnf < $page_content
rm -f $page_content
echo $(date +%s) Stored $page_content >> debugger.log

# index page content
cd ../indexes
mysql --defaults-extra-file=$cnf < page_dflt_ns_title.sql
echo $(date +%s) Indexed $page_content >> debugger.log

# get pagelinks content
cd ../content
pagelinks_content=$(../get_content.sh $pagelinks_url)
mysql --defaults-extra-file=$cnf < $pagelinks_content
rm -f $pagelinks_content
echo $(date +%s) Stored $pagelinks_content >> debugger.log

# index edges
cd ../indexes
mysql --defaults-extra-file=$cnf < edges_u1.sql
echo $(date +%s) Indexed $pagelinks_content >> debugger.log
