#!/usr/bin/env bash

# Include config
source /scripts/simple-automated-tasks/.tasks/sites.sh

for i in ${SITES[@]}
do
	cd "$ROOT/$i"
	php -q wp-cron.php >/dev/null 2>&1
done
