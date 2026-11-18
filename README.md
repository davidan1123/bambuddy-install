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

## Configuration (.env)
The compose file keeps all data on a Synology NAS: Bambuddy's folders over NFS
and its database in PostgreSQL on the NAS. A Portainer Agent (port 9001) is
included so a Portainer server can manage this host.

Site-specific settings are read from a `.env` file that is **not** committed:
```bash
cp .env.example .env
chmod 600 .env
nano .env   # set NAS_IP, NFS_PATH, DB_PASSWORD, DB_PORT, ...
```
`DB_PASSWORD` must be URL-encoded (`@` → `%40`, `!` → `%21`).

Prerequisites:
- `sudo apt install nfs-common` on the VM
- On the NAS: `data`, `logs`, `backups` folders under `NFS_PATH`, and an NFS
  permission rule for the VM's IP (Security `sys`, Squash "No mapping",
  "Allow users to access mounted subfolders" ticked)
- In PostgreSQL:
  ```sql
  CREATE USER bambuddy WITH PASSWORD '...';
  CREATE DATABASE bambuddy OWNER bambuddy;
  ```

## Notes:
- Works with Docker Compose v1 (docker-compose command)
- Tested on Ubuntu 24.04 with Docker 24.x
- Container runs in host networking mode for printer discovery
