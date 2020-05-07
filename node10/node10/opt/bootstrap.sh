#!/bin/bash

# The main entrypoint to the container
# Load global aliases
source ~/.bashrc

# Set default environment variables
export PROJECT_ENV=${PROJECT_ENV:-"prod"}

# Create additional directories if required
if [ -f "/opt/build_and_bootstrap-dir.sh" ]; then
  source /opt/build_and_bootstrap-dir.sh
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

npm run ${APP_RUN_SCRIPT:-"start"}
