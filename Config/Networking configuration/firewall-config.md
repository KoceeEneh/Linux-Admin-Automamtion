# Configuring Firewall 

this consists on how to configure firewall on a linux server 

## Steps

- Enable UFW & Allow SSH

```bash
sudo ufw enable
sudo ufw allow ssh
```

- Deny All Incoming, Allow Outgoing

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

- List Firewall Rules

```bash
sudo ufw status numbered
```

