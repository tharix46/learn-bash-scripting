#!/usr/bin/env bash

# a simple error logging function
# pass the command as an argument to the function
error_log_file=09-functions-errors.log

run_cmd_safe() {
  # "$@" represents all arguments passed to the function (the command)
  "$@" 2>> "$error_log_file"
  local status=$?

  if (( $status != 0 )); then
    echo "An error occurred, please check the $error_log_file"
    return $status
  else 
    echo "success: $@"
    return 0
  fi
}

# function calling
run_cmd_safe ls -l /home 



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