#!/usr/bin/env bash

#########################################
# this script checks the status of URLs listed in 03-urls.txt
# and prints a message based on the HTTP status code.
# to run this script: 
# 1. Ensure the script has executable permissions: chmod +x 03-url-checker.sh
# 2. Execute the script: ./03-url-checker.sh
#########################################

# Check if the url file exists
url_file=03-urls.txt

if [[ ! -f "$url_file" ]]; then
    echo "❌ URL list file '$url_file' not found."
    exit 1
fi

for url in $(cat 03-urls.txt); do
    status_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")

    if [[ "$status_code" -ge 200 && "$status_code" -lt 400 ]]; then
        printf "✅ %-50s [Status: %s]\n" "$url" "$status_code"
    else
        printf "❌ %-50s [Status: %s]\n" "$url" "$status_code"
    fi
done