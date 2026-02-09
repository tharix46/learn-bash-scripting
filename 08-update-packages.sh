#!/usr/bin/env bash

# check if sudo can be run without user entering password
sudo -n true &> /dev/null || { echo "Non-interactive sudo access is required. No prompts are used"; exit 1; }

# source os-release file
. /etc/os-release

# update packages
case "$ID" in
  ubuntu|debian|pop)
    sudo apt update
    sudo apt full-upgrade -y
    ;;
  rhel|centos|rocky|almalinux|fedora)
    sudo dnf makecache
    sudo dnf update -y
    ;;
  *)
    echo "Unsupported OS: $ID"
    exit 1
    ;;
esac
