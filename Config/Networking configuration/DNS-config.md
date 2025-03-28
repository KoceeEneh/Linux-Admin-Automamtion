# DNS Configuration
This consists on how to check and configure DNS

## Check DNS Configuration

```bash
cat /etc/resolv.conf
```

##  Manually Add a Host Entry (If No DNS Server)

```bash
echo "TARGET-IP <TARGET-SERVER>" | sudo tee -a /etc/hosts
ping target-server
``` 
