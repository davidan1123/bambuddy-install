# Bambuddy Docker Installation (Homelab)

Bambuddy on a Proxmox Docker VM, with all data on a Synology NAS:

- Data, logs and backups → Synology over NFS
- Database → PostgreSQL running on the Synology
- Portainer Agent (port 9001) so a Portainer server can manage this host

## Prerequisites
1. On the VM:
   ```bash
   sudo apt install nfs-common
   ```
2. On the Synology:
   - Create the folders `data`, `logs` and `backups` under `NFS_PATH`
     (default `/volume1/docker/bambuddy`).
   - NFS permission rule on the share for the VM's IP: Read/Write, Security `sys`,
     Squash "No mapping", "Allow users to access mounted subfolders" ticked.
3. In PostgreSQL (pgAdmin Query Tool):
   ```sql
   CREATE USER bambuddy WITH PASSWORD '...';
   CREATE DATABASE bambuddy OWNER bambuddy;
   ```

## Install
```bash
git clone https://github.com/davidan1123/bambuddy-install.git bambuddy-install
cd bambuddy-install
cp .env.example .env
chmod 600 .env
nano .env        # NAS_IP, DB_PASSWORD, DB_PORT, PORT
sudo docker compose up -d
sudo docker logs bambuddy --tail 30
```

Open `http://<vm-ip>:8000` (or the `PORT` you set in `.env`).

## Notes
- `DB_PASSWORD` must be URL-encoded (`@` → `%40`, `!` → `%21`), because it goes
  into Bambuddy's `DATABASE_URL` (unlike Gitea's plain password).
- The container uses host networking so printer discovery (SSDP multicast) and
  camera streaming work; Bambuddy's ports are the VM's ports.
- Only one Portainer Agent per Docker host: if this VM already runs one,
  remove the `portainer_agent` service from `docker-compose.yml`.
- Deploy from the shell, not as a Portainer stack (the agent would restart itself).
- Growing the VM's disk after resizing it in Proxmox: see
  [resizing-proxmox-file-size.md](resizing-proxmox-file-size.md).
