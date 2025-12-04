#!/bin/bash

# Script để tải và cài Vivaldi mới nhất trên Ubuntu/Debian
# Phiên bản hiện tại: 7.7.3851.58 (cập nhật từ vivaldi.com, ngày 04/12/2025)
# Chạy với: bash install_vivaldi.sh

set -e  # Dừng nếu có lỗi

VERSION="7.7.3851.58"
ARCH="amd64"
URL="https://downloads.vivaldi.com/stable/vivaldi-stable_${VERSION}-1_${ARCH}.deb"
FILE="vivaldi-stable_${VERSION}-1_${ARCH}.deb"
DOWNLOAD_DIR="$HOME/Downloads"

echo "Bắt đầu tải Vivaldi phiên bản $VERSION..."

# Tạo thư mục nếu chưa có
mkdir -p "$DOWNLOAD_DIR"
cd "$DOWNLOAD_DIR"

# Tải file (thử wget trước, fallback curl nếu không có wget)
if command -v wget >/dev/null 2>&1; then
    wget -O "$FILE" "$URL"
else
    curl -o "$FILE" "$URL"
fi

if [ ! -f "$FILE" ]; then
    echo "Lỗi: Tải file thất bại! Kiểm tra kết nối hoặc version."
    exit 1
fi

echo "Tải thành công. Bắt đầu cài đặt..."

# Cài đặt
sudo apt update
sudo apt install -y "./$FILE"

# Cleanup (tùy chọn)
# rm "$FILE"  # Uncomment nếu muốn xóa file sau khi cài

echo "Cài đặt hoàn tất! Chạy 'vivaldi' để mở browser."
echo "Lưu ý: Lần sau, Vivaldi sẽ tự update qua repo (sudo apt update && sudo apt upgrade vivaldi-stable)."
