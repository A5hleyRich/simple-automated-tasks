#!/usr/bin/env bash

# Include config
source sites.sh

# Pushbullet token
TOKEN=''

# Store sites with errors
ERRORS=""

for i in ${SITES[@]}
do
	cd "$ROOT/$i/public"
	# Verify checksums
	if ! wp core verify-checksums; then
		ERRORS="$ERRORS $i"
	fi
done

if [ -n "$ERRORS" ]; then
	curl -u $TOKEN: https://api.pushbullet.com/v2/pushes -d type=note -d title="Server" -d body="Checksums verification failed for the following sites:$ERRORS"
fi