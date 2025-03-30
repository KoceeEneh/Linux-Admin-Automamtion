# Configuring Firewall 

this consists on how to configure firewall on a linux server 

## Steps

- Enable UFW & Allow SSH

```bash
sudo ufw enable
sudo ufw allow ssh
```
- output
<img width="700" alt="Screenshot 2025-03-30 at 02 57 26" src="https://github.com/user-attachments/assets/73a94038-3150-4e6e-92f0-d2d23e460832" />


- Deny All Incoming, Allow Outgoing

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

- List Firewall Rules

```bash
sudo ufw status numbered
```
- output
<img width="701" alt="Screenshot 2025-03-30 at 02 58 59" src="https://github.com/user-attachments/assets/0d0cdcaa-b72e-4aeb-8551-b5ade28a122f" />

