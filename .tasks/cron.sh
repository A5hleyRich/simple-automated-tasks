#!/usr/bin/env bash

# Include config
source /home/a5hley/.tasks/sites.sh

for i in ${SITES[@]}
do
	cd "$ROOT/$i/public"
	php -q wp-cron.php >/dev/null 2>&1
done