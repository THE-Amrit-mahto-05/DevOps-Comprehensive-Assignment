#!/bin/bash

sudo apt update && sudo apt upgrade -y
if ! command -v docker &> /dev/null; then
   echo "Docker not found, installing..."
   curl -fsSL https://get.docker.com -o get-docker.sh
   sudo sh get-docker.sh
   sudo usermod -aG docker $USER
   echo "Docker installed. PLEASE LOG OUT AND LOG BACK IN for group changes to take effect, then run this script again."
   exit 0
fi

sudo systemctl start docker
sudo systemctl enable docker
if ! docker compose version &> /dev/null; then
   echo "Docker Compose not found, installing..."
   sudo apt install docker-compose-plugin -y
fi

docker compose up -d --build
