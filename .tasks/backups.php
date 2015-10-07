<?php

require_once './sites.php';

$file = date( 'Y-m-d-His' ) . '-database.sql';

foreach ( $sites as $site ) {
	chdir( $root . $site . '/public'  );
	// Backup database
	system( '/usr/local/bin/wp db export ../backups/' . $file . ' --add-drop-table' );
	// Compress database file
	system( 'gzip -f ../backups/' . $file );
	// Remove old backups
	system( 'find ../backups -mtime +30 | xargs rm -fR' );
	// Send to S3
	system( '/usr/local/bin/aws s3 cp ../backups/' . $file . '.gz s3://' . $site . '/backups/ --storage-class REDUCED_REDUNDANCY' );
}