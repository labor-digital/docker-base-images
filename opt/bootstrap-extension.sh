#!bin/bash

echo "Preparing development environment..."

# Check if we have a bootstrap-env file to run
if [ -f "/opt/bootstrap-env.sh" ]; then
  # Check if we have the env marker already before running the script
  if [ -f "/opt/bootstrap-env.ran" ]; then
    echo "Environment is already prepared (marker exists at: /opt/bootstrap-env.ran)"
  else
    source /opt/bootstrap-env.sh
    [[ $? -ne 0 ]] && exit 1
    touch /opt/bootstrap-env.ran
    service apache2 reload
  fi
fi

# Run the bootstrap dev file if we have one
if [ -f "/opt/bootstrap-dev.sh" ]; then
  source /opt/bootstrap-dev.sh
fi