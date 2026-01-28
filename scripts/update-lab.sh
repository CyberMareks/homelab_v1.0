#!/bin/bash
# High-Performance Home-Lab Updater
# Targets: Proxmox Host + All Running LXC Containers

echo "--- Starting Proxmox Host Update ---"
apt update && apt dist-upgrade -y

echo "--- Starting LXC Container Updates ---"
# Loop through all running container IDs
for container in $(pct list | awk '{if($2=="running") print $1}'); do
    echo "Updating Container ID: $container..."
    pct exec $container -- bash -c "apt update && apt dist-upgrade -y && apt autoremove -y"
done

echo "--- All Systems Updated Successfully ---"
