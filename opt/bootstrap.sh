#!/bin/bash

source ~/.bashrc
source /opt/directories.sh
set_permissions
source /opt/bootstrap-project.sh
set_permissions

apache2-foreground
