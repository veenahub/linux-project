#!/bin/bash
sudo apt-get upgrade  
sudo apt-get update
curl -LO https://github.com/Aarkan1/kittengram/archive/refs/heads/master.zip
sudo apt-get install unzip
sudo apt-get install default-jre
cd kittengram-master
sudo timedatectl set-timezone  GMT
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
sudo apt -y install nodejs
sudo npm install -g pm2
sudo pm2 start --name=kittengram java -- -jar server-1.0.jar
mkdir /home/ubuntu/backups
echo "0 3 * * * /home/ubuntu/backup.sh"  | crontab -e
sudo apt -y install nginx
sudo rm /etc/nginx/sites-enabled/default
sudo su
cat > /etc/nginx/sites-enabled/reverseproxy <<- "EOF"
  server {
    listen 80;
    server_name kittengram.veena.wiren.app;
    location / {
      proxy_pass http://localhost:4000;
    }
  }
  EOF
  sudo service nginx restart
  sudo apt -y install snapd
  sudo snap -y install core; sudo snap refresh core
  sudo snap -y install --classic certbot
  sudo ln -s /snap/bin/certbot /usr/bin/certbot
  sudo certbot --nginx
  sudo certbot --nginx -n -m veena.pattigulla@gmail.com --agree-tos -d kittengram.veena.wiren.app
  (crontab -l ; echo "0 0 4 */3 * sudo certbot renew")| crontab -