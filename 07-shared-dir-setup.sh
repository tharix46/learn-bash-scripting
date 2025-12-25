#!/usr/bin/env bash
set -euo pipefail
#########################################
# this script sets up a shared directory with specified ownership and permissions.
# to run this script:
# 1. Ensure the script has executable permissions: chmod +x 07-shared-dir-setup.sh
# 2. passwordless sudo access should be set up for the user running this script
# 3. Execute the script: ./07-shared-dir-setup.sh <directory_path> <owner> <group>
# eg: ./07-shared-dir-setup.sh /shared/dev tharindu developers
#########################################

if [[ $# -ne 3 ]]; then
  echo "usage: $0 <directory_path> <owner> <group>"
  echo "eg: $0 /shared/dev john developers"
  exit 1
fi 

DIR="$1"
OWNER="$2"
GROUP="$3"

# Create group if it doesn't exist
if ! getent group "$GROUP" > /dev/null; then
  echo "✌️ creating group $GROUP..."
  sudo groupadd "$GROUP"
fi

# Create the directory if it doesn't exist
if [ ! -d "$DIR" ]; then
  echo "✌️ creating directory $DIR..."
  sudo mkdir -p "$DIR"
fi

# Set ownership and permissions
echo "✌️ setting ownership and permissions..."
sudo chown "$OWNER:$GROUP" "$DIR"
sudo chgrp -R "$GROUP" "$DIR"
sudo chmod 2770 "$DIR"

# Set default ACLs so all future files get proper group access
echo "✌️ setting default ACLs..."
sudo setfacl -d -m g:$GROUP:rwx "$DIR"

# Done
echo "✅ shared directory setup completed at $DIR with group $GROUP"
