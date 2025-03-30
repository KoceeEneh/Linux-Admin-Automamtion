# Server Networking Configuration

This task provides step-by-step instructions for configuring basic networking between your servers, including static IP addressing, SSH key-based authentication, firewall rules, private networking, DNS resolution, and documentation.

## 1. Set Up Static IP Addressing

1. Identify network interfaces:
   
   ```bash
   nmcli device status

   ```
- Output
<img width="701" alt="Screenshot 2025-03-30 at 01 20 49" src="https://github.com/user-attachments/assets/0fb3cefd-1e9f-43e9-b2ef-e027d4a6445d" />

2. Set up a ststic IP address

```bash
mcli connection modify "Wired connection 1" ipv4.addresses 172.20.10.200/24
nmcli connection modify "Wired connection 1" ipv4.gateway 172.20.10.1
nmcli connection modify "Wired connection 1" ipv4.dns "8.8.8.8"
nmcli connection modify "Wired connection 1" +ipv4.dns "8.8.4.4"
nmcli connection modify "Wired connection 1" ipv4.method manual
nmcli connection up "Wired connection 1"
   ```
- Output
  
  <img width="783" alt="Screenshot 2025-03-30 at 01 15 47" src="https://github.com/user-attachments/assets/3ff9d765-b506-47d3-8562-423dbd047490" />


3. Verify the Static IP Configuration

```bash
ip a
```
- Output
  
<img width="700" alt="Screenshot 2025-03-30 at 01 18 08" src="https://github.com/user-attachments/assets/68244612-7bbf-4f5f-88bf-0bec33225eb1" />


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
- output

<img width="701" alt="Screenshot 2025-03-30 at 02 58 59" src="https://github.com/user-attachments/assets/643aa16c-9286-4fcd-a136-d8c4f950f4a5" />

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
