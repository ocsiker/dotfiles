#!/bin/bash
echo "=== Bắt đầu cài đặt Keyd ==="

# 2. Clone source code (tải vào thư mục tạm /tmp để không làm rác máy)
echo "[2/5] Đang tải source code keyd..."
cd /tmp
# Xóa thư mục cũ nếu lỡ chạy script nhiều lần
rm -rf keyd
git clone https://github.com/rvaiya/keyd.git
cd keyd

# 3. Build và cài đặt
echo "[3/5] Đang biên dịch và cài đặt..."
make
sudo make install

# 4. Tạo file cấu hình
echo "[4/5] Đang tạo file cấu hình /etc/keyd/default.conf..."

# Tạo thư mục nếu chưa tồn tại (đề phòng)
sudo mkdir -p /etc/keyd

# Ghi nội dung vào file config
# Logic: capslock = overload(nav, capslock)
# Lý do: Vì hệ thống đã swap sẵn, nên khi tap keyd gửi 'capslock' -> hệ thống đổi thành 'esc'.
sudo tee /etc/keyd/default.conf >/dev/null <<EOF
[ids]
*

[main]
# Giữ CapsLock -> Layer Nav
# Nhấn CapsLock -> Gửi CapsLock (Hệ thống sẽ tự swap thành Esc theo config cũ của bạn)
capslock = overload(nav, capslock)

[nav]
# VIM style navigation
h = left
j = down
k = up
l = right
#
# --- Cuộn chuột 4 chiều (Mouse Scroll) ---
# Dọc (Vertical)
p = scrollup
n = scrolldown
# Ngang (Horizontal) - Mới thêm
[ = scrollleft
] = scrollright
# --- Cuộn chuột (Mouse Wheel) ---

# Tiện ích bổ sung cho nav layer
b = C-left
w = C-right
u = home
e = end
backspace = delete
x = C-backspace
EOF

# 5. Kích hoạt và khởi động service
echo "[5/5] Đang khởi động service keyd..."
sudo systemctl enable keyd
sudo systemctl restart keyd

echo "=== Cài đặt hoàn tất! ==="
echo "Bạn có thể thử giữ CapsLock và nhấn H/J/K/L để di chuyển chuột ngay bây giờ."
echo "Nếu muốn kiểm tra log, hãy chạy: sudo keyd monitor"
