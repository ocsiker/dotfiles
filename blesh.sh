#!/bin/bash

# Dừng script ngay nếu có lệnh bị lỗi
set -e

echo "--- BẮT ĐẦU CÀI ĐẶT BLE.SH (FULL OPTION) ---"

# 1. Cài đặt các gói phụ thuộc (Dependencies) + FZF
# Thêm fzf vào danh sách cài đặt
echo "[1/5] Đang cập nhật và cài đặt dependencies (gawk, make, git, fzf)..."
sudo apt update -qq
sudo apt install -y gawk make git fzf

# 2. Tạo thư mục tạm để tải source code ble.sh
echo "[2/5] Đang tải mã nguồn ble.sh..."
TEMP_DIR=$(mktemp -d)
git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git "$TEMP_DIR/ble.sh"

# 3. Build và Install vào ~/.local/share/blesh
echo "[3/5] Đang build và cài đặt..."
make -C "$TEMP_DIR/ble.sh" install PREFIX=~/.local

# 4. Cấu hình .bashrc
echo "[4/5] Đang cấu hình .bashrc..."
BASHRC="$HOME/.bashrc"
BLE_STARTUP='[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh'

if grep -Fq "ble.sh" "$BASHRC"; then
	echo "    -> Cấu hình ble.sh đã có sẵn trong .bashrc. Bỏ qua."
else
	# Đưa ble.sh lên đầu file .bashrc
	echo -e "$BLE_STARTUP\n$(cat $BASHRC)" >"$BASHRC"
	echo "    -> Đã thêm ble.sh vào đầu file .bashrc"
fi

# 5. Cấu hình file .blerc (Vim mode + FZF + Auto-suggestion)
echo "[5/5] Đang tạo cấu hình nâng cao (.blerc)..."
BLERC="$HOME/.blerc"

# Luôn ghi đè hoặc tạo mới file cấu hình để đảm bảo cập nhật option mới nhất
cat <<EOT >"$BLERC"
# --- CẤU HÌNH VIM MODE ---
set -o vi
# Hiển thị rõ chế độ INSERT/NORMAL/REPLACE

# --- TÍCH HỢP FZF ---
# Kích hoạt FZF completion (Tab) và Key bindings (Ctrl-R, Ctrl-T)
ble-import -d integration/fzf-completion
ble-import -d integration/fzf-key-bindings
ble-import vim-surround
# --- CẤU HÌNH AUTO-SUGGESTION (GỢI Ý MỜ) ---
# Tích hợp Bash Completion
ble-import -d integration/bash-completion-r1
# (Mặc định đã bật, nhưng đây là các tùy chọn nếu bạn muốn chỉnh màu)
# ble-face auto_complete=fg=238,bg=terminal (Màu xám)

# --- KHÁC ---
EOT

echo "    -> Đã cập nhật file .blerc với FZF và Vim Mode."

# Dọn dẹp
rm -rf "$TEMP_DIR"

echo "--- CÀI ĐẶT HOÀN TẤT! ---"
echo "Hãy chạy lệnh: source ~/.bashrc"
