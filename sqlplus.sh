#!/usr/bin/env bash
# 1. Tạo thư mục và tải bộ cài (Phiên bản 19.x ổn định)
sudo mkdir -p /opt/oracle
cd /tmp
wget https://download.oracle.com/otn_software/linux/instantclient/1919000/instantclient-basic-linux.x64-19.19.0.0.0dbru.zip
wget https://download.oracle.com/otn_software/linux/instantclient/1919000/instantclient-sqlplus-linux.x64-19.19.0.0.0dbru.zip

# 2. Giải nén vào /opt/oracle
sudo unzip instantclient-basic-linux.x64-19.19.0.0.0dbru.zip -d /opt/oracle/
sudo unzip instantclient-sqlplus-linux.x64-19.19.0.0.0dbru.zip -d /opt/oracle/
sudo mv /opt/oracle/instantclient_19_19 /opt/oracle/instantclient

# 3. Cài đặt thư viện libaio (Khắc phục lỗi cho Ubuntu 24.04/Noble)
sudo apt update
sudo apt install libaio1t64

# 4. Tạo Symlink để đánh lừa Oracle (Sửa lỗi "cannot open shared object file")
cd /usr/lib/x86_64-linux-gnu
# Lệnh này trỏ cái tên cũ (libaio.so.1) vào file mới (libaio.so.1t64)
sudo ln -s libaio.so.1t64 libaio.so.1

# 5. Đăng ký thư viện với hệ thống (Sửa lỗi "libsqlplus.so" trong Neovim)
# Bước này thay thế cho việc set LD_LIBRARY_PATH thủ công dễ gây lỗi
echo "/opt/oracle/instantclient" | sudo tee /etc/ld.so.conf.d/oracle-instantclient.conf
sudo ldconfig
