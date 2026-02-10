#!/usr/bin/env bash


# a simple error logging function
error_log_file=functions_error.log

check_exit_status() {
  if [[ $? -ne 0 ]]; then
    echo "An error occurred, please check the $error_log_file"
  fi
}

ls -l /nonexist 2> $error_log_file

# function calling
check_exit_status


# check aws cli is configured using a function
check_aws_configured() {
  # 'local' limits variable scope to the function
  local file_name=~/.aws/credentials

  if [[ -f $file_name ]]; then
    echo "aws is configured"
  else
    echo "aws is not configured. Credentials file not exist"
  fi
}

# function calling
check_aws_configured