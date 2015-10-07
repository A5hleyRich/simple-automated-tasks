#!/usr/bin/env bash

# Include config
source sites.sh

for i in ${SITES[@]}
do
	cd "$ROOT/$i/public"
	php -q wp-cron.php >/dev/null 2>&1
done