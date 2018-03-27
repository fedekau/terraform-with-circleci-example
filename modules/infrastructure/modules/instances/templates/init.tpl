#!/bin/bash

# Set the hostname
sudo sed -i /etc/hosts -e "s/^127.0.0.1 localhost$/127.0.0.1 localhost $(hostname)/"

# Install mysql client
sudo apt-get install mysql-client -y

# Instal nvm and install the latest stable version of NodeJS
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
. ~/.nvm/nvm.sh
nvm install stable
nvm alias default stable

sudo rm /usr/bin/node
sudo ln -s /home/ubuntu/.nvm/versions/node/v9.9.0/bin/node /usr/bin/node

# Install http-server for serving simple static files
npm install http-server -g --quiet

# Create an instance-ip.txt file
mkdir /home/ubuntu/public
curl http://169.254.169.254/latest/meta-data/local-ipv4 > /home/ubuntu/public/instance-ip.txt

sudo systemctl stop web.service
sudo systemctl disable web.service

sudo rm /etc/systemd/system/web.service
sudo touch /etc/systemd/system/web.service

sudo echo "[Unit]" >> /etc/systemd/system/web.service
sudo echo "Description=Web" >> /etc/systemd/system/web.service
sudo echo "After=network-online.target" >> /etc/systemd/system/web.service
sudo echo "" >> /etc/systemd/system/web.service
sudo echo "[Service]" >> /etc/systemd/system/web.service
sudo echo "" >> /etc/systemd/system/web.service
sudo echo "ExecStart=/home/ubuntu/.nvm/versions/node/v9.9.0/bin/http-server /home/ubuntu/public -p 3000" >> /etc/systemd/system/web.service
sudo echo "WorkingDirectory=/home/ubuntu" >> /etc/systemd/system/web.service
sudo echo "Restart=always" >> /etc/systemd/system/web.service
sudo echo "RestartSec=10" >> /etc/systemd/system/web.service
sudo echo "StandardOutput=syslog" >> /etc/systemd/system/web.service
sudo echo "StandardError=syslog" >> /etc/systemd/system/web.service
sudo echo "SyslogIdentifier=Web" >> /etc/systemd/system/web.service
sudo echo "" >> /etc/systemd/system/web.service
sudo echo "[Install]" >> /etc/systemd/system/web.service
sudo echo "WantedBy=multi-user.target" >> /etc/systemd/system/web.service

sudo systemctl enable web.service
sudo systemctl start web.service

touch executed.txt
