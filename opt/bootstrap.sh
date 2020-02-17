#!/bin/bash

source ~/.bashrc
source /opt/directories.sh
set_permissions
source /opt/bootstrap-dev.sh
source /opt/bootstrap-project.sh
set_permissions

has_development_script () {
  [[ $(npm run | grep "^  start:development" | wc -l) > 0 ]]
}

if has_development_script; then
  npm run start:development
else
  npm start
fi