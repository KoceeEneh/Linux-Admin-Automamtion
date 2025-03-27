# Automating system maintainance with Cron Jobs

`Cron` is used to automate key system tasks, ensuring system health,security and efficiency.

---

## ** Scheduled Tasks**
| Task                    | Frequency           | Script   |
|-------------------------|---------------------|---------------------------------------|
| System Inventory        | Weekly              | `/usr/local/bin/system_inventory.sh`  |
| Network Monitoring      | Hourly              | `/usr/local/bin/network_monitor.sh`   |
| Backups                 | Daily (2 AM)        | `/usr/local/bin/backup_manager.sh`    |
| System Updates Check    | Daily (3 AM)        | `/usr/local/bin/system_update.sh`     |

## **Setting up Cron Jobs**

- to schedule the tasks use:

``` bash
`sudo crontab -e` and add:
```

- add the following:

```bash

#Run system inventory every Sunday at midnight
0 0 ** 0 /usr/local/bin/system_inventory.sh >> /var/log/system_inventory.log 2>&1

# Run network monitoring every hour
0 * * * * /usr/local/bin/network_monitor.sh >> /var/log/network_monitor.log 2>&1

# Run backups daily at 2 AM
0 2 * * * /usr/local/bin/backup_manager.sh >> /var/log/backup_manager.log 2>&1

# Check for system updates daily at 3 AM
0 3 * * * /usr/local/bin/system_update.sh >> /var/log/system_updates.log 2>&1
```
---

## **Logging setup for scripts**

Each scripts has this structured logging with timestamps:
 
```bash
LOG_FILE = "/var/log/script_name.log"

log_message() {
  local LEVEL = "$1"
  local MESSAGE = "$2"
  echo "$(date + %Y-%m-%d %H:%M:%S') [$LEVEL] $MESSAGE" | tee -a "$LOG_FILE"
}
log_message "INFO" "Script started"
log_message "ERROR" "Something went wrong"
log_message "SUCCESS" "Script completed successfully"
```
---

## **Log Rotation**

The following configuration would:

1. keep logs for 4 weeks
2. compress old logs
3. ignore empty logs

- install `logrotate`:

```bash
/var/log*.log {
  weekly
  rotate 4
  compress
  missingok
  notifempty
}
```
---

## **Email Alerts for critical events**

To send Email notifications for failure, this was added to the scripts:

```bash
send_email_alerts() {
local SUBJECT="CRITICAL ERROR: $1"
    local BODY="Timestamp: $(date)\n\n$2"
    echo -e "$BODY" | mail -s "$SUBJECT" admin@example.com
}
```
---

## sample output

`output from my kali machine`



