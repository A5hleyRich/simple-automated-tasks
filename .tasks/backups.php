<?php

require_once './sites.php';

$database_file = date( 'Y-m-d-His' ) . '-database.sql';
$uploads_file = date( 'Y-m-d-His' ) . '-uploads.tar.gz';

foreach ( $sites as $site ) {
	chdir( $root . $site . '/public'  );
	// Backup database
	system( '/usr/local/bin/wp db export ../backups/' . $database_file . ' --add-drop-table' );
	// Compress database file
	system( 'gzip -f ../backups/' . $database_file );
	# Backup uploads directory
	system( 'tar -zcf ../backups/' . $uploads_file . ' wp-content/uploads' );
	// Remove old backups
	system( 'find ../backups -mtime +30 | xargs rm -fR' );
	// Send to S3
	system( '/usr/local/bin/aws s3 cp ../backups/' . $database_file . '.gz s3://' . $site . '/backups/ --storage-class REDUCED_REDUNDANCY' );
	system( '/usr/local/bin/aws s3 cp ../backups/' . $uploads_file . ' s3://' . $site . '/backups/ --storage-class REDUCED_REDUNDANCY' );
}