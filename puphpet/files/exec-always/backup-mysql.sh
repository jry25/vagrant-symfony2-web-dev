#!/bin/bash

echo "Backup mysql databases"
backupDirectory='/vagrant/backup/databases/'$(date +%Y-%m-%d)'/'$(date +%H.%M.%S)
mkdir -p $backupDirectory
for db in $(mysql -u root -proot  -e 'show databases' -s --skip-column-names);
do
mysqldump --single-transaction -u root -proot  $db --default-character-set utf8 | gzip > $backupDirectory/$db-$(date +%Y-%m-%d-%H.%M.%S).sql.gz;
done
echo "Finished backup mysql databases"