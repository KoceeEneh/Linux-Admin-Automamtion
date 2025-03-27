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
