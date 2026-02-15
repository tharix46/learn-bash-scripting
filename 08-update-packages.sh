#!/usr/bin/env bash

# check if sudo can be run without user entering password
sudo -n true &> /dev/null || { echo "Non-interactive sudo access is required. No prompts are used"; exit 1; }

# source os-release file
. /etc/os-release

log_file="updater.log"
error_log_file="updater-error.log"

# update packages
case "$ID" in
  ubuntu|debian|pop)
    sudo apt update >> "$log_file" 2>> "$error_log_file"
    sudo apt full-upgrade -y >> "$log_file" 2>> "$error_log_file"
    ;;
  rhel|centos|rocky|almalinux|fedora)
    sudo dnf makecache >> "$log_file" 2>> "$error_log_file"
    sudo dnf update -y >> "$log_file" 2>> "$error_log_file"
    ;;
  *)
    echo "Unsupported OS: $ID"
    exit 1
    ;;
esac
