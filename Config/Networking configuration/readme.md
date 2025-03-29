# Server Networking Configuration

This task provides step-by-step instructions for configuring basic networking between your servers, including static IP addressing, SSH key-based authentication, firewall rules, private networking, DNS resolution, and documentation.

## 1. Set Up Static IP Addressing

1. Identify network interfaces:
   ```bash
   ip a
   ```
2. Edit the Netplan config file:
   ```bash
   sudo nano /etc/netplan/01-netcfg.yaml
   ```
3. The configuration file is in the repo
  
4. Apply changes:
   ```bash
   sudo netplan apply
   ```

## 2. Configure SSH with Key-Based Authentication
1. Generate SSH keys on your local machine:
   ```bash
   ssh-keygen -t rsa -b 4096
   ```
2. Copy the public key to the remote server:
   ```bash
   ssh-copy-id user@192.168.1.100
   ```
3. Disable password authentication (on the remote server):
   ```bash
   sudo nano /etc/ssh/sshd_config
   ```
   Set:
   ```
   PasswordAuthentication no
   PubkeyAuthentication yes
   ```
4. Restart SSH service:
   ```bash
   sudo systemctl restart sshd
   ```

## 3. Implement Basic Firewall Rules

### Using UFW 
```bash
sudo apt install ufw -y
sudo ufw allow OpenSSH
sudo ufw allow 80/tcp  # HTTP
sudo ufw allow 443/tcp  # HTTPS
sudo ufw enable
sudo ufw status
```

## 4. Set Up a Private Network Between Servers

### Option 1: Assign Private IPs in LAN
1. Assign static IPs in the **192.168.x.x** range.
2. Add entries to `/etc/hosts`:
   ```
   192.168.1.101 server1
   192.168.1.102 server2
   ```
3. Test with:
   ```bash
   ping server1
   ```
   
## 5. Configure and Test DNS Resolution
1. Edit `/etc/resolv.conf`:
   ```bash
   sudo nano /etc/resolv.conf
   ```
   Add:
   ```
   nameserver 8.8.8.8
   nameserver 8.8.4.4
   ```
2. Test DNS resolution:
   ```bash
   nslookup google.com
   ```
