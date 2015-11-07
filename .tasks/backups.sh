#!/usr/bin/env bash

# Include config
source /home/a5hley/.tasks/sites.sh

# Filenames
NOW=$(date +%Y-%m-%d-%H%M%S)
DATABASE_FILE="${NOW}-database.sql";
UPLOADS_FILE="${NOW}-uploads.tar.gz";

for i in ${SITES[@]}
do
	cd "$ROOT/$i/public"
	# Backup database
	wp db export "../backups/$DATABASE_FILE" --add-drop-table
	# Compress database file
	gzip -f "../backups/$DATABASE_FILE"
	# Backup uploads directory
	tar -zcf "../backups/$UPLOADS_FILE" wp-content/uploads
	# Remove old backups
	find ../backups -mtime +30 | xargs rm -fR
	# Send to S3
	aws s3 cp "../backups/$DATABASE_FILE.gz" "s3://$i/backups/" --storage-class REDUCED_REDUNDANCY
	aws s3 cp "../backups/$UPLOADS_FILE" "s3://$i/backups/" --storage-class REDUCED_REDUNDANCY
done