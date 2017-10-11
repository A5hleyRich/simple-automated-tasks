#!/usr/bin/env bash

# Include config
source /home/a5hley/.tasks/sites.sh

for i in ${SITES[@]}
do
	cd "$ROOT/$i/public"
	# Update themes
	/usr/local/bin/wp theme update --all
	# Update plugins
	/usr/local/bin/wp plugin update --all
	# Update languages
	/usr/local/bin/wp core language update
done
