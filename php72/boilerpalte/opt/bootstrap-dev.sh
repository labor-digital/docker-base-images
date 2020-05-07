#!/bin/bash
# ORDER: 3 | WHERE: DEV only (Container Start)
# This file is used to >>simulate build steps<< we execute for our production container

# Install composer dependencies
if [ -f "/var/www/html/composer.json" ]; then
	export COMPOSER_PROCESS_TIMEOUT=1200

	cd /var/www/html
	composer install
fi
