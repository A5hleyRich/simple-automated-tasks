#!/usr/bin/env bash

# Include config
source /scripts/simple-automated-tasks/.tasks/sites.sh

# Pushbullet token
TOKEN=''

# Store sites with errors
ERRORS=""

for i in ${SITES[@]}
do
	cd "$ROOT/$i"
	# Verify checksums
	if ! /usr/local/bin/wp core verify-checksums --allow-root; then
		ERRORS="$ERRORS $i"
	fi
done

if [ -n "$ERRORS" ]; then
	curl -u $TOKEN: https://api.pushbullet.com/v2/pushes -d type=note -d title="Server" -d body="Checksums verification failed for the following sites:$ERRORS"
fi
