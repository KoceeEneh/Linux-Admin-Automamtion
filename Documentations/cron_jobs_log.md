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




