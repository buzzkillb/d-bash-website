# d-bash-website  
Website Using Coin Daemon and BASH
## Requirements
```
coin daemon (denariusd or snap daemon)
jq
bc
```
### crontab -e (Denarius snap daemon)
```
# update html every 60 minutes
0 * * * * /snap/bin/denarius.daemon fortunastake list full > /var/www/html/fslist.json && /bin/sh /root/coinage.sh > /var/www/html/coinage.html
```
