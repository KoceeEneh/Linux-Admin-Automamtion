#!/bin/bash

#configuration
BACKUP_DIR = "/var/backups"
SOURCE_DIR = "/home/user/important_data"
MAX_BACKUPS = 5
LOG_FILE = "/var/log/backup.log"


#Function to check if command was successful
check_command() {
    if [ $? -eq 0 ]; then
        echo "Command executed successfully."
    else
        echo "Command failed."
    fi
}

#function to create a timestamped backup
create_backup() { 
    TIMESTAMP = $(date + "%Y-%m-%d_%H-%M-%S")
    BACKUP_FILE = "$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

    echo "Creating backup: $BACKUP_FILE"
    sudo tar -czf "$BACKUP_FILE" "$SOURCE_DIR"
    check_command "Creating backup"

    echo "backup successfully created: $BACKUP_FILE" | tee -a "$LOG_FILE"
}

#function to enforce backup rotation policy 
rotate_backups() {
    echo "cheching older backups..."
    BACKUP_COUNT = $(ls -l "$BACKUP_DIR"/backup_*.tar.gz 2>/dev/null | wc -l)

    if ["$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
        REMOVE_COUNT = $((BACKUP_COUNT - MAX_BACKUPS))
        echo "Removing $REMOVE_COUNT old backups..."
        ls -1t "$BACKUP_DIR"/backup_*.tar.gz | tail -$REMOVE_COUNT | xargs sudo rm --
        check_command "backup rotation"

    else 
        echo "no old backups to remove."
    fi
}

#function to verify backup integrity
verify_backup() {
    echo "Verifying backup integrity..."
    LATEST_BACKUP = $(ls -1t "$BACKUP_DIR"/backup_*.tar.gz | head -n 1)

    if [-f "$LATEST_BACKUP" ]; then
        tar -tzf "$LATEST_BACKUP" >/dev/null
        check_command "backup integrity verification"
        echo "Backup integrity verified: $LATEST_BACKUP" | tee -a "$LOG_FILE"

    else
        echo "No backup found." | tee -a "$LOG_FILE"
        exit 1 
    fi
}

#run backup process
create_backup
rotate_backups
verify_backup
