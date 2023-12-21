#!/bin/bash

apt-get update -y

apt install nginx -y

echo "<h1>Hostname: $(hostname)</h1>" > /var/www/html/index.html

systemctl restart nginx