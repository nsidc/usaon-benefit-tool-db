#!/bin/bash
set -e

if [ -z "${BACKUP_DIR}" ]; then
    echo "\$BACKUP_DIR must be set."
    exit 1
fi

if [ -z "${DB_USER}" ]; then
    echo "\$DB_USER must be set."
    exit 1
fi

if (facter cname | grep blue); then
    bkpfile="$BACKUP_DIR/usaon-benefit-tool-db-backup.blue.sql.gz"
else
    bkpfile="$BACKUP_DIR/usaon-benefit-tool-db-backup.sql.gz"
fi

docker exec --tty db pg_dumpall --clean --username "$DB_USER" | gzip > $bkpfile
echo "Backup saved to $bkpfile."
