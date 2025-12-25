#!/usr/bin/env bash
set -euo pipefail

#########################################
# this script is for get started with bash scripting
# where the user is greeted and shown some information 
# this script needs a ***positional parameter (verb)*** to be passed when running the script
# to run this script: 
# 1. Ensure the script has executable permissions: chmod +x 01-best-day-ever.sh
# 2. Execute the script: ./01-best-day-ever.sh <verb>
# <verb> can be any action like "coding", "learning", "exploring", etc.
#########################################

if [ $# -ne 1 ]; then
  echo "usage: $0 <verb>"
  echo "eg: $0 coding"
  exit 1
fi

verb=$1
user=$(whoami)
date_time=$(date)
current_dir=$(pwd)

echo -ne "\nWhat's your name? "
read -r name

sleep 1
echo -e "\nHello, $name! Welcome to the Day 1 of the DevOps Journey."
echo -e "keep $verb... \n"
sleep 1

echo "It's $date_time"
echo "You're logged in as user $user"
echo -e "You're in the $current_dir directory\n"
curl -sL https://wttr.in/ | head -n 7 || true
sleep 1