#!/bin/bash

set -e

echo "updating packages"
sudo apt-get update
echo "installing java"
sudo apt-get install -y openjdk-21-jdk

#Install Jenkins
echo "installing jenkins"
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get install -y jenkins

# Install Nginx
echo "installing nginx"
sudo apt-get install -y nginx

# Install Certbot for Let's Encrypt
echo "install certbot"
sudo apt-get install -y certbot python3-certbot-nginx