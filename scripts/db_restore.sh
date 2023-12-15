#!/bin/bash
set -e

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"


if [ -n "$1" ]; then
    bkpfile="$1"
elif [ -n "${BACKUP_DIR}" ]; then
    bkpfile="$(find $BACKUP_DIR -name "usaon-benefit-tool-db-backup.sql.gz*" | sort -r | head -1)"
fi

if [ -z "$bkpfile" ]; then
    echo "Please pass a backup file as argument or set \$BACKUP_DIR and ensure a backup file exists there"
    exit 1
fi

# restart to boot any active sesssions
docker-compose restart
$SCRIPTPATH/wait_for_db.sh

docker exec db dropdb usaon-benefit-tool || true
docker exec db createdb usaon-benefit-tool 

gunzip -c $bkpfile | docker exec --interactive db psql --username dbuser
echo "Restored from $bkpfile."
