#!/bin/bash
set -e
if [ ! -d "public-rhel-install" ]; then
  git clone https://github.com/xela-engineer/public-rhel-install.git
else
    git -C public-rhel-install pull --force
fi
./public-rhel-install/scripts/main.sh