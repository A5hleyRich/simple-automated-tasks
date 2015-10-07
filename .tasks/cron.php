<?php

require_once './sites.php';

foreach ( $sites as $site ) {
	chdir( $root . $site . '/public'  );
	system( 'php -q wp-cron.php >/dev/null 2>&1' );
}