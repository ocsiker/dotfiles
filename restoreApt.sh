#!/usr/bin/env bash
cd ~/backup_apt

# Khôi phục danh sách PPA
sudo cp ppa.list /etc/apt/sources.list.d/
sudo apt update

# Nếu có backup GPG, khôi phục bằng:
sudo cp -R trusted.gpg* /etc/apt/

# Cài lại các gói APT đã cài trước đó
xargs -a apt-packages.list sudo apt install -y

# Nếu backup bằng dpkg --get-selections, khôi phục bằng:
sudo dpkg --set-selections <packages.list
sudo apt-get dselect-upgrade -y

echo "Khôi phục hoàn tất!"
