#!/usr/bin/env bash

num1=10

# simple if statement
if (( num1 < 20 )); then
  echo "number is less than 20"
fi


# if else statement
if (( num1 > 20 )); then
  echo "number is greater than 20"
else 
  echo "number is less than 20"
fi


# if elif else statement
if (( num1 < 10 )); then
  echo "number is less than 10"
elif (( num1 == 10 )); then
  echo "number is equal to 10"
else 
  echo "number is greater than 10"
fi


# check if a file exists
if [[ -f ~/.aws/config ]]; then 
  echo "aws config file exists"
else
  echo "aws config file does not exist"
fi


# check if fastfetch is installed
tool="fastfetch"
if command -v $tool &> /dev/null; then
  $tool
else  
  # curly brackets are used to group multiple commands as one unit
  # because || accepts one command
  sudo -n true || { echo "Non-interactive sudo access is required. No prompts are used"; exit 1; }
  
  echo "$tool is not installed. Installing it..."
  sudo apt update && sudo apt install -y $tool
  
  $tool
fi
