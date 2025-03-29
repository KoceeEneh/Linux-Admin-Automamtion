# Linux Server Administration

This task sets up two Linux VMs: an admin server and a target server. It covers user management, package installation, service control, file system setup, and process monitoring.

## Prerequisite 
- Admin Server ( Ubuntu)
- Target Server (Kali Linux)


# Steps

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
- output
  
<img width="701" alt="Screenshot 2025-03-29 at 21 38 20" src="https://github.com/user-attachments/assets/690c033f-458c-4121-9afe-8379c9a95a4f" />


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

- Output

<img width="700" alt="Screenshot 2025-03-29 at 21 44 18" src="https://github.com/user-attachments/assets/93b9e82c-d712-49dc-a5bd-0f25c5ebb2a6" />


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
- Output

<img width="741" alt="Screenshot 2025-03-29 at 22 22 15" src="https://github.com/user-attachments/assets/fb6cfa22-c775-4a53-8297-eca7af10fb72" />


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
- output

<img width="700" alt="Screenshot 2025-03-29 at 22 25 51" src="https://github.com/user-attachments/assets/55816397-a3b2-4bd5-99f1-bd9fd5e02db1" />

## Process Management

- Monitor Running Processes

```bash
ps aux | grep <service>
htop
```

- Output A
<img width="867" alt="Screenshot 2025-03-29 at 22 28 29" src="https://github.com/user-attachments/assets/9284eb85-3e7d-443b-adbe-00f7aba047db" /> 

 - Output B
<img width="1440" alt="Screenshot 2025-03-29 at 22 28 54" src="https://github.com/user-attachments/assets/ed6953a8-5edc-4424-b100-5195bee5c355" /> 


- Kill a Process

```bash
sudo kill -9 <PID>
```
- Output

<img width="697" alt="Screenshot 2025-03-29 at 22 39 16" src="https://github.com/user-attachments/assets/834eaa30-36c0-4b3d-9ec1-8111aeb187bc" />

- Set process

```bash
nice -n 10 samplescript.sh
```




