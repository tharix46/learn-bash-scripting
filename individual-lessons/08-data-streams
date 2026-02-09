#!/usr/bin/env bash

# standard input
# here the input is provided by the user
echo -n "What is your name? "
read -r name
echo "Hello $name"


# standard output
# output of a command that is not an error, printed to the terminal is standard output
ls -l
date


# standard error
ls -l /notexist
echo $?

# standard errors will be printed to the terminal (if run as non-root user)
find /etc -type f > /dev/null

# standard errors will not be printed as they are redirected to /dev/null (if run as non-root user)
find /etc -type f 2> /dev/null
# errors are still there, only not printed to the terminal
echo $?

# send both standard error and standard output to /dev/null
find /etc -type f &> /dev/null