#!/bin/bash
sudo apt update -y &&
sudo apt install -y nginx
echo "DevOps Task-1 Completed by using Terraform" > /var/www/html/index.html