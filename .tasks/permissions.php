<?php

require_once './sites.php';

$file = date( 'Y-m-d-His' ) . '-database.sql';

foreach ( $sites as $site ) {
	chdir( $root . $site . '/public'  );
	// Files
	system( 'find . -type f -exec chmod 644 {} +' );
	// Directories
	system( 'find . -type d -exec chmod 755 {} +' );
	// wp-config.php
	system( 'chmod 600 wp-config.php' );
}