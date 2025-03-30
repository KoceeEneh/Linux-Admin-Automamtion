## NETWORK TOPOLOGY DIAGRAM

![linux-admin-Page-1](https://github.com/user-attachments/assets/6857c979-f260-4f15-8168-41a688b26cd6)

## IP ADDRESSING SCHEME

| Hostname         | IP address  | Role         | 
|------------------|-------------| ------------ |
| VM 1 (ubuntu)    | 172.20.10.4 | Admin server | 
| VM 2 (kali linux)| 172.20.10.2 | Target server|


## FIREWALL RULES 

- **SSH (Port 22):** Allowed only from trusted IPs.
  
- **HTTP (Port 80):** Open for web traffic.
  
- **HTTPS (Port 443):** Secure web access.
  
- **All other inbound connections blocked.**


## SERVICE PORT IN USE

| Service   | Port |
|-----------|------|
| SSH       | 22   |
| HTTP      | 80   |
| HTTPS     | 443  |
