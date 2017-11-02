#!/usr/bin/env bash

# Include config
source /scripts/simple-automated-tasks/.tasks/sites.sh



for i in ${SITES[@]}
do

	# Filenames
	NOW=$(date +%Y-%m-%d)
	DATABASE_FILE="$i-${NOW}-database.sql";
	FILES_FILE="$i-${NOW}-files.tar.gz";

	cd "$ROOT/$i"
	# Backup database
	/usr/local/bin/wp db export "../backups/$DATABASE_FILE" --add-drop-table
	# Compress database file
	gzip -f "../backups/$DATABASE_FILE"
	# Backup all files directory
	tar -zcf "../backups/$FIILES_FILE" ./
	# Remove old backups
	find ../backups -mtime +30 | xargs rm -fR
	# Send to S3
	# /usr/local/bin/aws s3 cp "../backups/$DATABASE_FILE.gz" "s3://$i/backups/" --storage-class REDUCED_REDUNDANCY
	# /usr/local/bin/aws s3 cp "../backups/$UPLOADS_FILE" "s3://$i/backups/" --storage-class REDUCED_REDUNDANCY
  # Send to Google Drive
	# gdrive upload -p 0ByACnvoLyNYDRURlVGJkcnByc0U welthaus.staging.agentur.auftrieb.at.tar.gz

done
