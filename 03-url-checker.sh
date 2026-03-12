#!/usr/bin/env bash
set -euo pipefail

#########################################
# this script checks the status of URLs listed in 03-urls.txt (or the user can provide different URLs file)
# and prints a message based on the HTTP status code.
# to run this script: 
# 1. Ensure the script has executable permissions: chmod +x 03-url-checker.sh
# 2. Execute the script: ./03-url-checker.sh or ./03-url-checker.sh <url-file-name.txt>
#########################################

# get the url file or fallback to default file
url_file="${1:-03-urls.txt}"

if [[ ! -f "$url_file" ]]; then
    echo "❌ URL list file '$url_file' not found."
    exit 1
fi

# check url status 

# the '-n "$url"' test checks if $url is not empty (non-zero length string).
# This ensures the last line is processed even if it doesn't end with a newline character.
# The loop continues as long as either: (1) read succeeds, OR (2) $url contains a non-empty string.
while read url || [[ -n "$url" ]]; do

    # check if the $url is empty or is it a comment. if yes, then skip
    [[ -z "$url" || "$url" =~ ^# ]] && continue
    
    status_code=$(curl -s -o /dev/null -w "%{http_code}" "$url") || true

    if (( status_code >= 200 && status_code < 400 )); then
        printf "✅ %-50s [Status: %s]\n" "$url" "$status_code"
    else
        printf "❌ %-50s [Status: %s]\n" "$url" "$status_code"
    fi
done < $url_file