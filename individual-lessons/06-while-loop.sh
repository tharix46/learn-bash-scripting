#!/usr/bin/env bash

# loop through numbers
num=0

while (( num <= 5 )); do
  echo $num
  (( num++ ))
done


# read a file with while loop
file="03-basic-math.sh"

while read -r line || [[ -n $line ]]; do
  echo "$line"
done < "$file"


# this is an infinite loop
while true; do
  echo "this is an infinite loop. Press ctrl+c to exit"
  sleep 5
done