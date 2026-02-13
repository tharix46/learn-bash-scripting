#!/usr/bin/env bash

error_log_file=09-functions-errors.log

# a simple error logging function
# pass the command as an argument to the function
run_cmd_safe() {
  # "$@" represents all arguments passed to the function (the command)
  # 2> >(...): This is Process Substitution. 
  # It treats the code inside the parentheses as a file that stderr can write to.
  "$@" 2> >( while read -r line; do echo "$(date '+%Y-%m-%d %H:%M:%S') - ERR: $line" >> "$error_log_file"; done )
  
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
run_cmd_safe ls -l /notexist



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