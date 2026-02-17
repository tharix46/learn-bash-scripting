#!/usr/bin/env bash
set -euo pipefail

#########################################
# this script updates packages on the system based on the Linux distribution (Ubuntu, Debian, RHEL, CentOS, Rocky, AlmaLinux, Fedora)
# the user must have non-interactive sudo access to run this script, as it will not prompt for a password
# to run this script: 
# 1. Ensure the script has executable permissions: chmod +x 08-update-packages.sh
# 2. Execute the script: ./08-update-packages.sh
#########################################

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
