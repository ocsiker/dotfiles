#!/bin/bash

# Dừng script nếu có lỗi
set -e

# --- TỰ ĐỘNG PHÁT HIỆN USER THẬT ---
# Nếu chạy bằng sudo, lấy user gọi sudo. Nếu không, lấy user hiện tại.
REAL_USER=${SUDO_USER:-$USER}

# Nếu đang chạy trực tiếp bằng root (login root), thì không chấp nhận
if [ "$REAL_USER" == "root" ]; then
	echo "LỖI: Bạn không nên chạy script này khi đang login trực tiếp bằng Root."
	echo "Hãy login bằng user thường và chạy: sudo ./script.sh"
	exit 1
fi

# Lấy đường dẫn Home thật của user
REAL_HOME=$(getent passwd $REAL_USER | cut -d: -f6)

echo "--- Đang setup cho User: $REAL_USER ---"
echo "--- Thư mục Home thật: $REAL_HOME ---"

# Màu sắc
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=== BẮT ĐẦU SETUP HỆ THỐNG UBUNTU (MINIMAL/I3) ===${NC}"

# --- PHẦN 1: CHUẨN BỊ MÔI TRƯỜNG ---
echo -e "${GREEN}[1/7] Cập nhật và cài đặt công cụ nền tảng...${NC}"
sudo apt update
sudo apt install -y git stow curl unzip wget apt-transport-https software-properties-common

# --- PHẦN 2: THÊM REPOSITORIES ---
echo -e "${GREEN}[2/7] Thêm nguồn phần mềm (Repositories)...${NC}"

# Hàm chạy script con dưới quyền User thật (để tránh lỗi permission)
run_as_user() {
	sudo -u $REAL_USER bash "$@"
}

# 2.1 Vivaldi
if [ -f "$REAL_HOME/dotfiles/vivaldi.sh" ]; then
	if dpkg -l | grep -q vivaldi-stable; then
		echo "Vivaldi đã được cài đặt, bỏ qua."
	else
		echo "Install Vivaldi..."
		# Vivaldi script thường cần sudo bên trong nó, nên chạy bash thường
		bash "$REAL_HOME/dotfiles/vivaldi.sh"
	fi
else
	echo "Warning: Không tìm thấy $REAL_HOME/dotfiles/vivaldi.sh"
fi

# 2.2 Docker
if ! command -v docker &>/dev/null; then
	echo "    - Cài đặt Docker..."
	curl -fsSL https://get.docker.com | sh
	sudo usermod -aG docker $REAL_USER # Add đúng user thật vào group
else
	echo "    - Docker đã cài đặt."
fi

# 2.3 eza
if [ -f "$REAL_HOME/dotfiles/eza.sh" ]; then
	if dpkg -l | grep -q eza; then
		echo "eza đã cài đặt."
	else
		bash "$REAL_HOME/dotfiles/eza.sh"
	fi
fi

# 2.4 getnf
if [ -f "$REAL_HOME/dotfiles/getnf.sh" ]; then
	if dpkg -l | grep -q getnf; then
		echo "getnf đã cài đặt."
	else
		bash "$REAL_HOME/dotfiles/getnf.sh"
	fi
fi

# 2.5 git_completion
if [ -f "$REAL_HOME/dotfiles/git_completion.sh" ]; then
	echo "Install git_completion..."
	bash "$REAL_HOME/dotfiles/git_completion.sh"
fi
#
# 2.6 github gh
if [ -f "$REAL_HOME/dotfiles/gh.sh" ]; then
	if dpkg -l | grep -q gh; then
		echo "eza đã cài đặt."
	else
		bash "$REAL_HOME/dotfiles/gh.sh"
	fi
fi
sudo apt update

# --- PHẦN 3: CÀI APP TỪ PKGLIST ---
echo -e "${GREEN}[3/7] Cài đặt ứng dụng từ pkglist...${NC}"

# Cài LightDM và deps
sudo apt install -y lightdm lightdm-gtk-greeter lightdm-settings lightdm-autologin-greeter \
	libxi-dev libxinerama-dev libxft-dev libxfixes-dev libxtst-dev libx11-dev \
	libcairo2-dev libxkbcommon-dev libwayland-dev scdoc libspnav-dev

# Restore LightDM config (Cần quyền root -> giữ nguyên sudo cp)
if [ -f "system/lightdm.conf" ]; then
	echo "    - Restore cấu hình lightdm..."
	sudo cp system/lightdm.conf /etc/lightdm/
fi

if [ -f "pkglist.txt" ]; then
	grep -vE '^\s*#|^\s*$' pkglist.txt | xargs sudo apt install -y || echo "Có lỗi nhỏ khi cài package."
fi

# Fix codec Vivaldi
if command -v /opt/vivaldi/update-ffmpeg &>/dev/null; then
	sudo /opt/vivaldi/update-ffmpeg
fi

# --- PHẦN 4: APP THỦ CÔNG ---
echo -e "${GREEN}[4/7] Cài đặt ứng dụng thủ công...${NC}"

# 4.1 SQLcl
if [ ! -d "/opt/sqlcl" ] && [ -f "sqlcl-latest.zip" ]; then
	echo "    - Cài SQLcl..."
	sudo unzip -q sqlcl-latest.zip -d /opt/
	sudo ln -sf /opt/sqlcl/bin/sql /usr/local/bin/sql
	sudo chown -R $USER:$USER /opt/sqlcl
fi

# 4.2 FZF (QUAN TRỌNG: Cài vào Home của User thật)
if [ ! -d "$REAL_HOME/.fzf" ]; then
	echo "    - Cài FZF cho user $REAL_USER..."
	# Chạy lệnh git clone dưới quyền user thật
	sudo -u $REAL_USER git clone --depth 1 https://github.com/junegunn/fzf.git $REAL_HOME/.fzf
	sudo -u $REAL_USER $REAL_HOME/.fzf/install --all --no-update-rc
else
	echo "    - FZF đã cài đặt."
fi

# 4.3 Warpd
if ! command -v warpd &>/dev/null; then
	echo "    - Cài Warpd..."
	rm -rf /tmp/warpd
	git clone https://github.com/rvaiya/warpd.git /tmp/warpd
	pushd /tmp/warpd >/dev/null
	make clean && make && sudo make install
	popd >/dev/null
fi

# 4.4 Keyd
if [ -f "keyd.sh" ]; then
	bash keyd.sh
fi

# --- PHẦN 5: CẤU HÌNH HỆ THỐNG ---
echo -e "${GREEN}[5/7] Cấu hình hệ thống...${NC}"

sudo systemctl enable lightdm

# 5.4 Vivaldi Preferences (Copy vào Home thật)
if [ -f "system/Preferences" ]; then
	echo "    - Restore Vivaldi Preferences..."
	# Tạo thư mục với quyền của User thật
	sudo -u $REAL_USER mkdir -p $REAL_HOME/.config/vivaldi/Default/
	sudo -u $REAL_USER cp system/Preferences $REAL_HOME/.config/vivaldi/Default/Preferences
fi

# --- PHẦN 6: DOTFILES (STOW) ---
echo -e "${GREEN}[6/7] Stow Dotfiles...${NC}"

# 6.2 Stow (QUAN TRỌNG: Chạy dưới quyền User thật)
if [ -f "$REAL_HOME/dotfiles/home/stow.sh" ]; then
	echo "    - Running Stow..."
	# Chuyển thư mục làm việc và chạy script
	cd $REAL_HOME/dotfiles/home
	# Gọi stow.sh nhưng đảm bảo nó chạy với quyền user, không phải root
	sudo -u $REAL_USER bash $REAL_HOME/dotfiles/home/stow.sh
else
	echo "Not found: $REAL_HOME/dotfiles/home/stow.sh"
fi

# 6.3 Blesh
if [ -f "$REAL_HOME/dotfiles/blesh.sh" ]; then
	sudo -u $REAL_USER bash $REAL_HOME/dotfiles/blesh.sh
fi

# 6.4 Ibus
if [ -f "$REAL_HOME/dotfiles/ibusbamboo.sh" ]; then
	bash $REAL_HOME/dotfiles/ibusbamboo.sh
fi

# --- PHẦN 7: DỌN DẸP ---
sudo apt autoremove -y
sudo apt clean

echo -e "${BLUE}=== HOÀN TẤT! User: $REAL_USER ===${NC}"
