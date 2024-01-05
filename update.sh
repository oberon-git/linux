#!/bin/bash

git checkout main >> /dev/null 2>&1
git pull >> /dev/null 2>&1
. install.sh -s >> /dev/null
echo "update sucessful"

