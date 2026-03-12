#!/usr/bin/env bash

# number of arguments is defined as '$#'
# check if the number of arguments is exactly 1 or not
if (( $# != 1 )); then
  echo "Please provide exactly one directory path as an argument"
  exit 1
fi

# first arg - '$1'
# if there is a second arg, then - '$2'
echo "Checking... $1"

lines=$(ls -l $1 | wc -l)
echo "You have $(( lines-1 )) objects in $1"