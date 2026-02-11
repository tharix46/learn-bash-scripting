#!/usr/bin/env bash
set -euo pipefail

# Check if the required number of arguments are passed
if (( $#!=2)); then 
  echo "usage: $0 <source dir> <target dir>"
  echo "eg: $0 /home/dir /backup"
  exit 1
fi

# Check if the rsync is installed
if ! command -v rsync > /dev/null 2>&1; then
  echo "Error: rsync is not installed."
  echo "Please install rsync."
  exit 2
fi

# get the date in the format YYYY-MM-DD
backup_date=$(date +%F)

# convert both src and dst paths to absolute paths
src_dir=$(realpath "$1")
dst_dir=$(realpath "$2")

# log file
log_file="dir-backup-$backup_date.log"

echo -e "\nStarting backup from '$src_dir' to '$dst_dir'..."

# rsync command to start backup 
# -a : archive mode
# -v : verbose
# -b : backup (before overwriting/deleting a file keep a copy)
# --backup-dir : where backups from '-b' go
# --delete : if file removed from source, remove from target as well
rsync -avb \
--backup-dir "$dst_dir/$backup_date" \
--delete \
"$src_dir/" \
"$dst_dir/current/" >> "$log_file"

echo -e "\n✅ Backup complete. Logs at '$log_file'"