#!/usr/bin/env bash
set -euo pipefail

#########################################
# this script checks the health of servers listed in 05-servers.txt
# and prints a message based on the health metrics.
# to run this script: 
# 1. password-less SSH access should be set up for the servers listed in 05-servers.txt
# 2. .ssh/config file should be configured for the servers listed in 05-servers.txt
# 3. Ensure the script has executable permissions: chmod +x 05-server-health.sh
# 4. Execute the script: ./05-server-health.sh
#########################################

server_file="${1:-05-servers.txt}"

# Check if the file exists
if [[ ! -f "$server_file" ]]; then
    echo "❌ Server list file '$server_file' not found."
    exit 1
fi

# loop through each server in the file for check its health
while read server || [[ -n "$server" ]]; do
# for server in $(cat "$server_file"); do

    # Check if the SSH command is successful and parse the output to get uptime, CPU usage, memory usage
    # '-n' in ssh command will redirect stdin from /dev/null. so, SSH will not wait for keyboard input
    if ssh_output=$(ssh -n -o ConnectTimeout=5 $server "uptime -p; top -bn1 | grep 'Cpu(s)'; free -m; df -h" 2>/dev/null); then
        # uptime
        uptime=$(echo "$ssh_output" | head -n 1)

        # CPU
        cpu_idle=$(echo "$ssh_output" | grep "Cpu(s)" | awk -F',' '{print $4}' | awk '{print $1}')
        cpu_used_percent=$(awk -v idle="$cpu_idle" 'BEGIN { printf "%.1f", 100 - idle }')

        # Memory
        mem_total=$(echo "$ssh_output" | grep Mem: | awk '{print $2}')
        mem_used=$(echo "$ssh_output" | grep Mem: | awk '{print $3}')
        mem_used_percent=$(awk -v used="$mem_used" -v total="$mem_total" 'BEGIN { printf "%.1f", (used/total)*100 }')

        # Disk
        disk_used_percent=$(echo "$ssh_output" | grep -E ' /$' | awk '{print $5}' | tr -d '%')

        printf "✅ %-10s  %-40s  %5s%%CPU  %5s%%RAM  %5s%%DISK\n" "$server" "$uptime" "$cpu_used_percent" "$mem_used_percent" "$disk_used_percent"
    else
        printf "❌ %-10s  %-40s  \n" "$server" "unable to connect"
    fi
done < $server_file