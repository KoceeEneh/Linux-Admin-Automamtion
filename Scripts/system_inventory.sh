#!/bin/bash

# Define output file
REPORT="system_inventory_report.txt"

# Function to check if the last command was successful
check_command() {
    if [ $? -eq 0 ]; then
        echo "$1 successful"
    else
        echo "$1 failed to execute"
        exit 1
    fi
}

# Collecting hardware information
CPU_INFO=$(lscpu | grep 'Model name' | awk -F ':' '{print $2}' | sed 's/^ *//')
check_command "CPU information collection"

MEMORY_INFO=$(free -h | awk '/^Mem:/ {printf "Total: %s, Used: %s, Free: %s", $2, $3, $4}')
check_command "Memory information collection"

DISK_INFO=$(lsblk -o NAME,SIZE,TYPE,MOUNTPOINT | awk '$3=="disk" {printf "%-10s %-10s\n", $1, $2}')
check_command "Disk information collection"

# Listing installed packages
INSTALLED_PACKAGES=$(dpkg-query -W -f='${binary:Package}\n' 2>/dev/null)
check_command "Installed packages listing"

# Identifying running services
if command -v jq &> /dev/null; then
    RUNNING_SERVICES=$(systemctl list-units --type=service --state=running --output=json-pretty 2>/dev/null | jq -r '.[].unit')
    check_command "Running services identification"
else
    echo "Warning: 'jq' not found. Skipping JSON parsing of running services."
    RUNNING_SERVICES=$(systemctl list-units --type=service --state=running | awk '{print $1}' | tail -n +2)
fi

# Output to report file
{
    echo "===== System Inventory Report ====="
    echo ""
    echo "** Hardware Information **"
    echo "CPU: $CPU_INFO"
    echo "Memory: $MEMORY_INFO"
    echo "Disk Info:"
    echo "$DISK_INFO"
    echo ""
    echo "** Installed Packages **"
    echo "$INSTALLED_PACKAGES"
    echo ""
    echo "** Running Services **"
    echo "$RUNNING_SERVICES"
} > "$REPORT"

check_command "Generating report"

echo "✅ System Inventory report generated: $REPORT"
exit 0
