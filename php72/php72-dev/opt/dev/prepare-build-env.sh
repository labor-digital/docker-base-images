#!/bin/bash

# Load global aliases
source /root/.bashrc

# Create additional directories if required
if [ -f "/opt/directories.sh" ]; then
source /opt/directories.sh
fi

# Set the correct permissions for the files
set_permissions