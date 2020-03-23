#!/bin/bash

# Update the sources list
sudo apt-get update -y

# upgrade any packages available
sudo apt-get upgrade -y

# install nginx
sudo apt-get install nginx -y

# install git
sudo apt-get install git -y
git --version

# install nodejs
sudo apt-get install python-software-properties
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs -y
sudo apt-get install npm -y

nodejs --version

# install pm2
sudo npm install pm2 -g

# https://www.hostinger.co.uk/tutorials/how-to-set-up-nginx-reverse-proxy/

sudo unlink /etc/nginx/sites-enabled/default

cd etc/nginx/sites-available/
sudo touch reverse-proxy.conf

reverse-proxy.conf << EOF
server {
        listen 80;
        listen [::]:80;

 

        access_log /var/log/nginx/reverse-access.log;
        error_log /var/log/nginx/reverse-error.log;

 

        location / {
                    proxy_pass http://192.168.10.100:3000;
  }
}
EOF

sudo ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf
sudo service nginx configtest
sudo service nginx restart

cd /home/ubuntu/app
nodejs app.js