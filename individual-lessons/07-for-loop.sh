#!/usr/bin/env bash

# loop through numbers
for i in {1..5}; do  
  echo $i 
  sleep 0.5
done

# archive log file in logfiles directory
for file in logfiles/*.log; do
  tar -czvf $file.tar.gz $file
done