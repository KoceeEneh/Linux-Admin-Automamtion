#!/bin/bash

LOG_FILE= "/var/log/network_monitor.log"
ALERT_THRESHOLD= 100

#function to check if command was successful
check_command() {
    if [ $? -eq 0 ]; then
        echo "Command executed successfully."
    else
        echo "Command failed."
    fi
}


#function to monitor network connections
monitor_connections() {
    echo "[ $(date) ] checking for unusual network activity..." | tee -a "$LOG_FILE"
    suspicious=$(netstat -tunapl | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head -n 10)
    echo "$suspicious" | tee -a "$LOG_FILE"
    if echo "$suspicious" | awk '{if ($1 > '"$ALERT_THRESHOLD"') {print $2}}' | grep -q '.'; then
        echo "ALERT: Unusual network activity detected!" | tee -a "$LOG_FILE"
    fi
}


#function to test connectivity btween servers
test_connectivity() {
    read -p "Enter target IP or hostname: " target
    echo "[ $(date) ] testing connectivity to $target..." | tee -a "$LOG_FILE"
    ping -c 4 "$target" | tee -a "$LOG_FILE"
    check_command "testing connectivity to $target"
    
}


#function to report bandwidth usage 
report_bandwidth_usage() { 
    echo "[ $(date) ] checking bandwidth usage..." | tee -a "$LOG_FILE"
    if command -v iftop &>/dev/null; then
        sudo iftop -t -s 5 | tee -a "$LOG_FILE"
    elif command -v vnstat &>/dev/null; then
        vnstat -l -i eth0 | tee -a "$LOG_FILE"
    else
        echo "Error: iftop or vnstat not installed. install one for bandwidth monitoring." | tee -a "$LOG_FILE"
        exit 1
    fi
    check_command"reporting bandwidth usage"
    
}



#display menu
echo "Network Monitoring Menu:"
echo "1. Monitor network connections"
echo "2. log unusual network activity"
echo "3. Test connectivity"
echo "4. Report bandwidth usage"
echo "5. Run All Checks"
echo "6. Exit"
read -p "Enter choice: " choice

case $choice in 
    1) monitor_connections ;;
    2) monitor_connections ;;
    3) test_connectivity ;;
    4) report_bandwidth_usage ;;
    5) monitor_connections && test_connectivity && report_bandwidth_usage ;;
    6) exit 0 ;;
    *) echo "Invalid choice. Exiting..." && exit 1 ;;

esac