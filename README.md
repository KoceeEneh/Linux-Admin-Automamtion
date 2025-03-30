# Linux-Admin-Automamtion

## Overview
This mini-project demonstrates essential skills in Linux administration, Git, Bash scripting, and networking. The goal is to create automation tools for managing a small Linux server environment, track changes using Git, and monitor system performance efficiently. it contains detailed documentations of whole process

## Project Structure
```
project-root/

│── scripts/            # Bash automation scripts
│── config/             # Configuration files
│── monitoring/         # Network and system monitoring scripts
│── documentation/      # Project documentation
│── README.md           # Project overview and setup instructions
│── .gitignore          # Git ignore file

```

## Project Requirements

### Part 1: Linux Server Administration

- Set up two Linux virtual machines:

- Admin Server (used for management)

- Target Server (to be managed)

- Configure SSH authentication with key-based login.

- Demonstrate:

- User Management (creating users, managing groups, permissions)

- Package Management (installing/configuring software)

- Service Management (configuring/enabling services)

- File System Management (partitioning, mounting, storage management)

- Process Management (monitoring and controlling processes)

### Part 2: Networking Configuration

- Configure basic networking between the servers:

- Set up static IP addresses.

- Secure SSH authentication.

- Implement firewall rules using iptables or ufw.

- Set up a private network.

- Configure and test DNS resolution.

- Create a network documentation file with:

- Network topology diagram

- IP addressing scheme

- Firewall rule explanations

- Service ports in use

### Part 3: Bash Automation Scripts

- system_inventory.sh - Collects system hardware info, installed packages, and running services.

- user_manager.sh - Manages users, groups, and SSH key authentication.

- system_hardening.sh - Secures SSH, disables unnecessary services, updates packages, and enforces security policies.

- network_monitor.sh - Monitors network connections, logs unusual activity, and reports bandwidth usage.

- backup_manager.sh - Automates backups, implements rotation policy, verifies integrity, and logs backup operations.

### Part 4: Cron Jobs & Logging

- The cron jobs was set up to:

- Run system inventory weekly.

- Run network monitoring hourly.

- Perform daily backups.

- Check for system updates daily.

- centralized logging was implemented to:

- Configure log rotation.

- Add timestamps and appropriate log levels.

- Enable email notifications for critical events.


## Setting up

### 1. clone the repository

```bash
git clone https://github.com/KoceeEneh/linux-admin-automation.git
cd linux-admin-automation
```

### 2. set up the environment

following *part 1* to set up your linux VMs and networking

### 3. Run Authomation Scripts

Navigate to the `scripts/` directory and execute the scripts 

### 4. Configure Cron Jobs

edit using:

```bash
crontab -e
```





