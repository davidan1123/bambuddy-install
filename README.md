# Bambu Buddy Docker Installation (Homelab Modified)

This is a modified version of the Bambu Buddy Docker installation script for our homelab environment.

## Modifications Made:
- Added Docker Compose v1 compatibility (the original script expects v2)
- Fixed container creation for legacy Docker environments
- Optimized for our Proxmox cluster setup

## Installation:
```bash
# Download and run
sudo usermod -aG docker $USER
git clone https://github.com/davidan1123/bambuddy-install.git
cd bambuddy-install
chmod +x docker-install.sh
sudo ./docker-install.sh
```

## Notes:
- Works with Docker Compose v1 (docker-compose command)
- Tested on Ubuntu 24.04 with Docker 24.x
- Container runs in host networking mode for printer discovery
