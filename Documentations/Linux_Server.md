# Linux Server Administration

This task sets up two Linux VMs: an admin server and a target server. It covers user management, package installation, service control, file system setup, and process monitoring.

## Prerequisite 
- Admin Server ( Ubuntu)
- Target Server (Kali Linux)


## Steps

## Create User Managment
- create user on the target server
  
```bash
sudo adduser sysadmin1
sudo usermod -AG sudo sysadmin
```

- verify user

```bash
su -sysadmin1
whoami
```

## Configure SSH with Key-Based Authentication

- On Admin server (Ubuntu) , generate SSH key:

``` bash
ssh-keygen -t ed25519 -c "admin@ubuntu"
```

- copy key to Target Server:
```bash
ssh-copy-id sysadmin@<TARGET_SERVER_IP>
```

- Disable password login for better security:
  
```bash
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart ssh
```

## Package Management

- Update and install packages
  
``` bash
udo apt update && sudo apt upgrade -y
sudo apt install htop net-tools ufw fail2ban -y
```

- check installed packages

```bash
dpkg --list | grep apache
```

- Remove unwanted packages

```bash
sudo apt remove <package> -y
```

## Service Management

- Enable & Start Services

```bash
sudo systemctl enable --now ssh
sudo systemctl start --now ssh
```

- Check Service Status

``` bash
sudo systemctl status ssh
```

- Stop & Disable a Service

```bash
sudo systemctl stop --now ssh
sudo systemctl disable --now ssh
```

## File System Management

- Check Disk Partition

```bash
lsblk
```

- Mount a New Partition

```bash
sudo mkdir /mnt/data
sudo mount /dev/sdb1 /mnt/data
```

## Process Management

- Monitor Running Processes

```bash
ps aux | grep <service>
htop
```




