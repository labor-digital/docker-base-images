#!/bin/bash
# ORDER: 1 && 3 | WHERE: PROD (Build) and DEV (Container Start)
# Allows you to create additional required directories and set their permissions
# You can use setPerms() and makeDir() (See .bashrc) to make your life easier.
#
# WARNING: This file runs twice on Container start when the DEV Container is booting up; once before
# build_and_bootstrap-env.sh and once after build_and_bootstrap-env.sh