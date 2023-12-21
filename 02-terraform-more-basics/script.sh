#!/bin/bash
sudo apt update
sudo apt install nginx
sudo touch /var/www/html/index.html
sudo chown -R $USER:$USER /var/www
sudo echo "<h1>Hostname: $(hostname)</h1>" > /var/www/html/index.html
sudo systemctl restart nginx