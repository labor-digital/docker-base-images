#!/bin/bash

# Runs when the container is being build

# Load global aliases
source /root/.bashrc

# Create additional directories if required
if [ -f "/opt/directories.sh" ]; then
  source /opt/directories.sh
fi

# Used as a hook to run the build script of our dev container
if [ -f "/opt/dev/build.sh" ]; then
  source /opt/dev/build.sh
fi

# Run additional build steps defined by the project
if [ -f "/opt/build.sh" ]; then
  source /opt/build.sh
fi

# Set the correct permissions for the files
set_permissions