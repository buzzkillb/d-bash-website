# d-bash-website  
Website Using Coin Daemon and BASH
## Requirements
```
coin daemon (denariusd or snap daemon)
sudo apt install jq bc
```
## Begin  
```
install nginx
wget style.css into /var/www/html
wget coinage.sh into /root/ or /home/username/ (adjust crontab to the full path)
also adjust crontab from coinage.html to index.html
```
### crontab -e (Denarius snap daemon)
```
# update html every 60 minutes
0 * * * * /snap/bin/denarius.daemon fortunastake list full > /var/www/html/fslist.json && /bin/sh /root/coinage.sh > /var/www/html/coinage.html
```
sample site  
https://pos.watch/coinage.html
