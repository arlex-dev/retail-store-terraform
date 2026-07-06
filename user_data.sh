#!/bin/bash
set -e

# Update system
apt-get update -y
apt-get upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install Git
apt-get install -y git

# Clone the retail store repo
cd /home/ubuntu
git clone https://github.com/arlex-dev/retail-store-microservices.git
cd retail-store-microservices

# Create .env file
echo "MYSQL_PASSWORD=store-local-pass" > .env

# Build and start the application
docker-compose build
docker-compose up -d

echo "Retail store deployed successfully!"
echo "Access the app at http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):8888"
