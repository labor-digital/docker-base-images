#!/bin/bash

# The main entrypoint to the container
# Load global aliases
source ~/.bashrc

# Load additional functions
source /opt/bootstrap-functions.sh

# Define default environment variables if the have not been set yet
source /opt/bootstrap-env-vars.sh

# Create additional directories if required
if [ -f "/opt/bootstrap-dir.sh" ]; then
  source /opt/bootstrap-dir.sh
fi

# Allows child containers to extend the bootstrap
# This is used for the development container!
if [ -f "/opt/bootstrap-extension.sh" ]; then
  source /opt/bootstrap-extension.sh
fi

# Run project specific bootstrap if required
if [ -f "/opt/bootstrap-project.sh" ]; then
  source /opt/bootstrap-project.sh
fi

apache2-foreground
