#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root. Use sudo."
	exit 1
fi

# Stop snapd service
echo "Stopping snapd service..."
systemctl stop snapd
systemctl disable snapd

# Remove all installed snaps
echo "Removing all installed snaps..."
snap list | awk '{print $1}' | grep -v "Name" | while read snapname; do
	snap remove --purge "$snapname"
done

# Remove snapd package and dependencies
echo "Removing snapd package..."
apt-get remove --purge -y snapd

# Clean up residual files and configurations
echo "Cleaning up residual files..."
rm -rf /snap /var/snap /var/lib/snapd /var/cache/snapd
rm -rf ~/snap

# Remove snap-related mounts
echo "Unmounting snap-related mounts..."
umount /snap/* 2>/dev/null
umount /var/snap/* 2>/dev/null

# Clean up apt cache
echo "Cleaning up apt cache..."
apt-get autoremove -y
apt-get autoclean

echo
