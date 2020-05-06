#!/bin/bash
# ORDER: 3 | WHERE: DEV only (Container Start)
# This file is used to >>simulate build steps<< we execute for our production container

# Install npm dependencies
if [ -f "/var/www/html/package.json" ]; then
	cd /var/www/html
	npm install
fi
