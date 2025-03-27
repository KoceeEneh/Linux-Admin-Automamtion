#!/bin/bash

LOG_FILE = "/var/log/daily_system_report.log"
REPORT_FILE = "/var/log/system_report.log"


#function to check if commands were successful
check_command() {
    if [ $? -eq 0 ]; then
        echo "Command executed successfully."
    else
        echo "Command failed."
    fi
}

#generate system report
echo "system report - $(date)" > "$REPORT_FILE"

#system uptime
echo "system uptime:" >> "$REPORT_FILE"
uptime -p >> "$REPORT_FILE"
check_command "fetching system uptime"


#disk usage
echo "memory usage:" >> "$REPORT_FILE"
free -h >> "$REPORT_FILE"
check_command "fetching memory usage"

#memory usage
echo "memory usage:" >> "$REPORT_FILE"
free -h >> "$REPORT_FILE"
check_command "fetching memory usage"

#failed login attempts(last 24 hours)
echo "failed login attempts(last 24 hours):" >> "$REPORT_FILE"
sudo journalctl -u ssh --since "24 hours ago" | grep "Failed password" >> "$REPORT_FILE"
check_command "fetching failed login attempts"

#package update status
echo "pending updates:" >> "$REPORT_FILE"
sudo apt update -qq && apt list --upgradable 2>/dev/null >> "$REPORT_FILE"
check_command "checking package updates"

echo "daily system report completed! report saved to $REPORT_FILE" | tee -a "$LOG_FILE"
