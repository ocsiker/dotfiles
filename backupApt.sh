#!/usr/bin/env bash

mkdir -p ./backup_apt && cd ./backup_apt

# Backup danh sách gói APT
sudo dpkg --get-selections >packages.list

# Backup danh sách các gói từ repository (không tính gói cài thủ công)
sudo apt list --installed | awk -F/ '{print $1}' >apt-packages.list

# Backup danh sách PPA đã thêm
grep -rhE ^deb /etc/apt/sources.list* >ppa.list

# Backup danh sách các khóa GPG (nếu có)
sudo cp -R /etc/apt/trusted.gpg* ./

echo "Backup hoàn tất! Tất cả dữ liệu đã được lưu trong thư mục backup_apt"
