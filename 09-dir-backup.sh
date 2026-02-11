#!/usr/bin/env bash
set -euo pipefail

# Check if the required number of arguments are passed
if (( $#!=2)); then 
  echo "usage: $0 <source dir> <target dir>"
  echo "eg: $0 /home/dir /backup"
  exit 1
fi

# Check if the rsync CLI is installed
if ! command -v rsync > /dev/null 2>&1; then
  echo "this script requires rsync to be installed."
  echo "please install rsync."
  exit 2
fi



