#!/usr/bin/env bash
set -euo pipefail

#########################################
# this script analyzes log files updated in last 24 hours in a specified directory and checks for error patterns in the logs.
# to run this script: 
# 1. Ensure the script has executable permissions: chmod +x 06-log-analyzer.sh
# 2. Execute the script: ./06-log-analyze.sh <directory_path>
#    where <directory_path> is the path to the directory containing log files.
# ****************************************
# for the testing purposes, this script uses 06-application.log and 06-system.log (should have been modified with last 24 hours) in the current directory.
# command: ./06-log-analyzer.sh .
# *****************************************
#########################################

# Check if the directory path is provided
if (( $# != 1 )); then
  echo "usage: $0 <directory_path>"
  echo "eg: $0 /myapp/logs"
  exit 1
fi

log_files=$(find $1 -name "*.log" -mtime -1)
error_patterns=("\[ERROR\]" "\[FATAL\]" "\[CRITICAL\]")
warnings=()

# Check if any log files were found
if [[ -z "$log_files" ]]; then
  echo -e "\n❌ No log files found in the specified directory updated in the last 24 hours."
  exit 1
fi

# Print the list of log files found
echo -e "\n✅List of log files updated in last 24 hours"
echo "$log_files"

# Loop through each log file and check for error patterns
for log_file in $log_files; do
  for error_pattern in ${error_patterns[@]}; do  
    error_count=$(grep -c "$error_pattern" "$log_file" || true)
    display_pattern="${error_pattern//\\/}"
    echo -e "\n\n❗️ $display_pattern logs in $log_file - [$error_count]"
    grep "$error_pattern" "$log_file" || true

    # If the error count is greater than or equal to 10, add a warning
    if (( $error_count >= 10 )); then
        warnings+=("⚠️  ALERT: $error_count $display_pattern logs in $log_file")
    fi
  done
done
 
# Print warnings if any
if (( ${#warnings[@]} > 0 )); then
  printf "\n%s\n" "${warnings[@]}"
fi

