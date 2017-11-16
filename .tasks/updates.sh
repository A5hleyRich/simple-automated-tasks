#!/usr/bin/env bash

# Include config
source /scripts/simple-automated-tasks/.tasks/sites.sh

for i in ${SITES[@]}
do
	cd "$ROOT/$i"
	# Update themes
	/usr/local/bin/wp theme update --all --allow-root
	# Update plugins
	/usr/local/bin/wp plugin update --all --allow-root
	# Update languages
	/usr/local/bin/wp core language update --allow-root
done
