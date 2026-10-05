#!/usr/bin/env bash
#
# Bambu Buddy Docker Installation Script (Homelab Modified)
# Modified for Proxmox cluster environment
#
# Usage:
#   sudo ./docker-install.sh --path /opt/bambuddy --port 8000 --yes
#

set -e

# Check for root or sudo
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root or with sudo"
    exit 1
fi

# Check for Docker
if ! command -v docker &> /dev/null; then
    echo "Docker not found. Installing Docker..."
    curl -fsSL https://get.docker.com | sh
fi

# Check for Docker Compose v1
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose v1 not found. Installing..."
    sudo apt-get install -y docker-compose
fi

# Installation path
INSTALL_PATH="${1:-/opt/bambuddy}"
PORT="${2:-8000}"

echo "Creating installation directory: $INSTALL_PATH"
mkdir -p $INSTALL_PATH

# Download the modified docker-compose.yml
echo "Downloading docker-compose.yml..."
wget -O $INSTALL_PATH/docker-compose.yml https://raw.githubusercontent.com/davidan1123/bambuddy-install/main/docker-compose.yml

# Start Bambu Buddy
echo "Starting Bambu Buddy..."
cd $INSTALL_PATH
docker-compose up -d

echo "✓ Bambu Buddy installation complete!"
echo "Access at: http://localhost:$PORT"
echo "Container name: bambuddy"
echo ""
echo "Useful commands:"
echo "  docker ps -a | grep bambuddy"
echo "  docker logs bambuddy"
echo "  docker-compose down"
