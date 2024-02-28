#!/bin/bash

source ~/.bashrc
source /opt/readEnv.sh
export APACHE_WEBROOT=${APACHE_WEBROOT:-"/var/www/html"}
export APACHE_LOG_DIR=${APACHE_LOG_DIR:-"/var/www/logs"}
export PROJECT_ENV=${PROJECT_ENV:-"prod"}
source /opt/directories.sh
set_permissions
source /opt/bootstrap-project.sh
set_permissions

# Fix for older apache2 versions
source /etc/apache2/envvars

apache2-foreground
