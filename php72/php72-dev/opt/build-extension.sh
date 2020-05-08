#!bin/bash

echo "Running enironment build steps..."

# Check if we have a build_and_bootstrap-env file to run
if [ -f "/opt/build_and_bootstrap-env.sh" ]; then
    source /opt/build_and_bootstrap-env.sh

  # Re-create additional directories if they changed in the extension script
  if [ -f "/opt/build_and_bootstrap-dir.sh" ]; then
    source /opt/build_and_bootstrap-dir.sh
  fi
fi