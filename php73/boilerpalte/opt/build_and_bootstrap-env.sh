#!/bin/bash
# ORDER: 2 | WHERE: PROD (Build) and DEV (Container Start)
# This file is meant to install additional dependencies to your images which are not already installed
# in our base images (LDAP, redis...)

# Install dev symlinker
if [[ $PROJECT_ENV = "dev" ]]; then
  composer global require labor-digital/composer-dev-symlink
fi
