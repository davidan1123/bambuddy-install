# Resizing Proxmox File Size

Commands to resize the volume group and filesystem:

## Step 1
sudo lvextend -r -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv

## Step 2
sudo resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
