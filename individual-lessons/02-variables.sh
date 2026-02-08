#!/usr/bin/env bash

# using simple variables
name="Tharindu"
topic="Linux"

echo "Hello, I am $name."
echo "I'm learning $topic."


# command substitution
# date and pwd commands will run in background and store the outputs in variables
now=$(date)
current_dir=$(pwd)

echo "System time and date is: $now"
echo "You're in $current_dir."


# using environment variables
echo "Your user name is $USER."
echo "Your shell is $SHELL."