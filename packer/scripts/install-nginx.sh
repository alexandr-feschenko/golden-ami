#!/bin/bash
#Update dependencies
sudo dnf update -y
sudo dnf install nginx -y
#Move html to nginx
sudo mv /tmp/index.html /usr/share/nginx/html/index.html
#Start nginx
sudo systemctl enable nginx
sudo systemctl start nginx
