#!/bin/bash

# Override the start command if we have a development script
if [[ $(npm run | grep "^  start:development" | wc -l) > 0 ]]; then
  export APP_RUN_SCRIPT=${APP_RUN_SCRIPT:-"start:development"}
fi