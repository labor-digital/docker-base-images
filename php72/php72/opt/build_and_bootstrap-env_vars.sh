#!/bin/bash

# Set default environment variables
export APACHE_WEBROOT=${APACHE_WEBROOT:-"/var/www/html"}
export APACHE_LOG_DIR=${APACHE_LOG_DIR:-"/var/www/logs"}
export PROJECT_ENV=${PROJECT_ENV:-"prod"}