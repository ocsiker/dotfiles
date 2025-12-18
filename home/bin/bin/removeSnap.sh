#!/bin/bash

# Check if script is run as root
sudo snap remove --purge lxd
sudo snap remove --purge core22
sudo snap remove --purge snapd
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

# Kiểm tra nếu file chưa tồn tại, tạo file mới
FILE="/etc/apt/preferences.d/nosnap.pref"
if [ ! -f "$FILE" ]; then
  echo "File $FILE không tồn tại, tạo file mới..."
  sudo touch "$FILE"
fi

# Thêm cấu hình vào file nếu chưa có
echo -e "Package: snapd\nPin: release a=*\nPin-Priority: -10" | sudo tee -a "$FILE" > /dev/null

echo "Đã thêm cấu hình vào $FILE"
