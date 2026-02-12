#!/usr/bin/env bash
set -euo pipefail

# check if the required number of arguments are passed
(( $# == 2 )) || { echo "usage: $0 <source dir> <target dir>"; exit 1; }

# check if the rsync is installed
command -v rsync > /dev/null 2>&1 || { echo "Error: rsync is not installed."; exit 2; }

# check if the target directory is there
[[ -d "$2" ]] || { echo -e "\nCreating target directory..."; mkdir -p "$2"; }

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