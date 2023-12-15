#!/bin/bash
set -e

if [ -z "${BACKUP_DIR}" ]; then
    echo "\$BACKUP_DIR must be set."
fi

if (facter cname | grep blue); then
    bkpfile="$BACKUP_DIR/usaon-benefit-tool-db-backup.blue.sql.gz"
else
    bkpfile="$BACKUP_DIR/usaon-benefit-tool-db-backup.sql.gz"
fi

docker exec --tty db pg_dumpall --clean --username dbuser | gzip > $bkpfile
echo "Backup saved to $bkpfile."
