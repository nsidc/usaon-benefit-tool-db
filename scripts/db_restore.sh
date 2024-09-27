#!/bin/bash
set -e

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"


if [ -n "$1" ]; then
    bkpfile="$1"
fi

if [ -z "$bkpfile" ]; then
    echo "Please pass a path to a backup file as argument."

    if [ -n "$BACKUP_DIR" ]; then
        echo "They can most likely be found in ${BACKUP_DIR}."
    fi
    exit 1
fi

# restart to boot any active sesssions
docker compose restart
$SCRIPTPATH/wait_for_db.sh

docker exec db dropdb --user="${DB_USER}" usaon-benefit-tool || true
docker exec db createdb --user="${DB_USER}" usaon-benefit-tool 

gunzip -c $bkpfile | docker exec --interactive db psql --username "$DB_USER"
echo "Restored from $bkpfile."
