#!/bin/bash

# Runs when the container is being build

# Load global aliases
source /root/.bashrc

# Set default environment variables
source /opt/build_and_bootstrap-env_vars.sh

# Create additional directories if required
if [ -f "/opt/build_and_bootstrap-dir.sh" ]; then
  source /opt/build_and_bootstrap-dir.sh
fi

# Allows child containers to extend the build process
# This is used for the development container!
if [ -f "/opt/build-extension.sh" ]; then
  source /opt/build-extension.sh
fi