#!/usr/bin/env bash

# Include config
source /scripts/simple-automated-tasks/.tasks/sites.sh

for i in ${SITES[@]}
do
	cd "$ROOT/$i"
	# Files
	find . -type f -exec chmod 644 {} +
	# Directories
	find . -type d -exec chmod 755 {} +
	# wp-config.php
	chmod 600 wp-config.php
done
