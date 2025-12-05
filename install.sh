#!/bin/bash

# Dừng script nếu có lỗi, không chạy tiếp để tránh hỏng hệ thống
set -e

# Màu sắc thông báo
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== BẮT ĐẦU SETUP HỆ THỐNG UBUNTU (MINIMAL/I3) ===${NC}"

# --- PHẦN 1: CHUẨN BỊ MÔI TRƯỜNG ---
echo -e "${GREEN}[1/7] Cập nhật và cài đặt công cụ nền tảng...${NC}"
sudo apt update
# Cài các gói cần thiết để chạy script này
sudo apt install -y git stow curl unzip wget apt-transport-https software-properties-common

# --- PHẦN 2: THÊM REPOSITORIES (VIVALDI, DOCKER) ---
echo -e "${GREEN}[2/7] Thêm nguồn phần mềm (Repositories)...${NC}"

# 2.1 Vivaldi Browser
if [ -f "$HOME/dotfiles/vivaldi.sh" ]; then
	if dpkg -l | grep -q vivaldi-stable; then
		echo "Vivaldi đã được cài đặt rồi, bỏ qua."
	else
		echo "install vivaldi browser"
		bash $HOME/dotfiles/vivaldi.sh
	fi
else
	echo "cannot run file  $HOME/dotfiles/vivaldi.sh"
fi

# 2.2 Docker (Dùng script tiện ích chính chủ)
if ! command -v docker &>/dev/null; then
	echo "    - Cài đặt Docker Engine..."
	curl -fsSL https://get.docker.com | sh
	# Thêm user vào group docker (dùng docker không cần sudo)
	sudo usermod -aG docker $USER
else
	echo "    - Docker đã được cài đặt."
fi

# 2.3 eza
if [ -f "$HOME/dotfiles/eza.sh" ]; then
	if dpkg -l | grep -q eza; then
		echo "eza đã được cài đặt rồi, bỏ qua."
	else
		echo "install eza"
		bash $HOME/dotfiles/eza.sh
	fi
else
	echo "cannot run file  $HOME/dotfiles/eza.sh"
fi


# 2.4 getnf
if [ -f "$HOME/dotfiles/getnf.sh" ]; then
	if dpkg -l | grep -q getnf; then
		echo "getnf đã được cài đặt rồi, bỏ qua."
	else
		echo "install getnf"
		bash $HOME/dotfiles/getnf.sh
	fi
else
	echo "cannot run file  $HOME/dotfiles/getnf.sh"
fi

# 2.4 git_completion
if [ -f "$HOME/dotfiles/git_completion.sh" ]; then
	if dpkg -l | grep -q ; then
		echo "git_completion đã được cài đặt rồi, bỏ qua."
	else
		echo "install git_completion"
		bash $HOME/dotfiles/git_completion.sh
	fi
else
	echo "cannot run file  $HOME/dotfiles/git_completion.sh"
# Cập nhật lại apt sau khi thêm repo
sudo apt update

# --- PHẦN 3: CÀI ĐẶT APP TỪ DANH SÁCH (PKGLIST) ---
echo -e "${GREEN}[3/7] Cài đặt ứng dụng từ pkglist.txt...${NC}"

# Đảm bảo cài Neovim (nếu chưa có trong list) và LightDM cơ bản
sudo apt install -y lightdm lightdm-gtk-greeter lightdm-settings lightdm-autologin-greeter \
	libxi-dev \
	libxinerama-dev \
	libxft-dev \
	libxfixes-dev \
	libxtst-dev \
	libx11-dev \
	libcairo2-dev \
	libxkbcommon-dev \
	libwayland-dev \
	scdoc \
	libspnav-dev
if [ -f "system/lightdm.config" ]; then
	echo "    - Restore cấu hình lightdm cho ocsiker..."
	sudo cp system/lightdm.conf /etc/lightdm/
fi

if [ -f "pkglist.txt" ]; then
	# Lọc bỏ các gói hệ thống cũ không còn tồn tại hoặc gây lỗi
	# xargs cài song song giúp nhanh hơn
	grep -vE '^\s*#|^\s*$' pkglist.txt | xargs sudo apt install -y || echo -e "${RED}Có một số gói lỗi, nhưng script vẫn tiếp tục...${NC}"
else
	echo "Warning: Không tìm thấy pkglist.txt"
fi

# Fix lỗi codec video cho Vivaldi
if command -v /opt/vivaldi/update-ffmpeg &>/dev/null; then
	echo "    - Fix codec Vivaldi..."
	sudo /opt/vivaldi/update-ffmpeg
fi

# --- PHẦN 4: CÀI ĐẶT APP NGOÀI (SQLcl, FZF) ---
echo -e "${GREEN}[4/7] Cài đặt ứng dụng thủ công...${NC}"

# 4.1 SQLcl (Từ file zip trong repo)
if [ ! -d "/opt/sqlcl" ] && [ -f "sqlcl-latest.zip" ]; then
	echo "    - Cài đặt SQLcl..."
	sudo unzip -q sqlcl-latest.zip -d /opt/
	sudo ln -sf /opt/sqlcl/bin/sql /usr/local/bin/sql
	echo "    - Xong SQLcl."
elif [ -d "/opt/sqlcl" ]; then
	echo "    - SQLcl đã cài đặt."
else
	echo "    - Không thấy file sqlcl-latest.zip, bỏ qua."
fi

# 4.2 FZF (Cài từ Git để có keybindings Ctrl+R, Ctrl+T)
if [ ! -d "$HOME/.fzf" ]; then
	echo "    - Cài đặt FZF (Git version)..."
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --all --no-update-rc
	# (--all: bật keybindings, --no-update-rc: để ta tự config trong stow bashrc)
else
	echo "    - FZF đã cài đặt."
fi
# 4.3 CÀI ĐẶT WARPD (BUILD FROM SOURCE) ---
echo -e "${GREEN}[5/8] Cài đặt Warpd (Mouse Control)...${NC}"

if ! command -v warpd &>/dev/null; then
	echo "    - Đang tải và biên dịch Warpd..."
	# Clone vào thư mục tạm /tmp để không làm rác máy
	rm -rf /tmp/warpd
	git clone https://github.com/rvaiya/warpd.git /tmp/warpd
	#
	# Vào thư mục và build
	pushd /tmp/warpd >/dev/null
	make clean
	make
	# Cài đặt vào /usr/local/bin
	sudo make install
	popd >/dev/null
	echo "    - Đã cài đặt Warpd thành công."
else
	echo "    - Warpd đã được cài đặt."
fi
# 4.4 CÀI ĐẶT Keyd (BUILD FROM SOURCE) ---
if [ -f "keyd.sh" ]; then
	bash keyd.sh
fi

# --- PHẦN 5: CẤU HÌNH HỆ THỐNG (/etc) ---
echo -e "${GREEN}[5/7] Cấu hình hệ thống...${NC}"

# 5.1 Keyboard (/etc/default/keyboard)
if [ -f "system/keyboard" ]; then
	echo "    - Restore cấu hình bàn phím..."
	sudo cp system/keyboard /etc/default/keyboard
	sudo udevadm trigger --subsystem-match=input --action=change
fi

# 5.2 LightDM config
if [ -f "system/lightdm.conf" ]; then
	echo "    - Restore cấu hình bàn phím..."
	sudo cp system/lightdm.conf /etc/lightdm/
fi

# 5.3 LightDM (Enable service)
# Không dùng Slick Greeter, dùng mặc định GTK
sudo systemctl enable lightdm

# --- PHẦN 6: DOTFILES (STOW) ---
echo -e "${GREEN}[6/7] Stow Dotfiles...${NC}"

# 6.1 Xử lý xung đột file mặc định (Backup file cũ)
#echo "    - Backup file config mặc định..."
#[ -f "$HOME/.bashrc" ] && [ ! -L "$HOME/.bashrc" ] && mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
#[ -f "$HOME/.bash_profile" ] && [ ! -L "$HOME/.bash_profile" ] && mv "$HOME/.bash_profile" "$HOME/.bash_profile.bak"
#[ -f "$HOME/.profile" ] && [ ! -L "$HOME/.profile" ] && mv "$HOME/.profile" "$HOME/.profile.bak"
#[ -f "$HOME/.gitconfig" ] && [ ! -L "$HOME/.gitconfig" ] && mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak"

#
# 6.2 Chạy Stow
cd $HOME/dotfiles/home
if [ -f "$HOME/dotfiles/home/stow.sh" ]; then
	bash $HOME/dotfiles/home/stow.sh
else
	echo " not found $HOME/dotfiles/home/stow.sh"
fi

# 6.3 Chạy blesh
echo -e "${GREEN}[6/7] Blesh Dotfiles...${NC}"
if [ -f "$HOME/dotfiles/blesh.sh" ]; then
	bash $HOME/dotfiles/blesh.sh
else
	echo " not found $HOME/dotfiles/blesh.sh"

# 6.3 Chạy ibus-bammbo
echo -e "${GREEN}[6/7] ibus-bammbo Dotfiles...${NC}"
if [ -f "$HOME/dotfiles/ibusbamboo.sh" ]; then
	bash $HOME/dotfiles/ibusbammbo.sh
else
	echo " not found $HOME/dotfiles/ibusbammbo.sh"
fi
echo "--- Hoàn tất! ---"

echo "    - Đã link xong: i3, rofi, polybar, bash, git, nvim, blesh..."

# --- PHẦN 7: DỌN DẸP ---
echo -e "${GREEN}[7/7] Dọn dẹp hệ thống...${NC}"
sudo apt autoremove -y
sudo apt clean

echo -e "${BLUE}=== HOÀN TẤT! HÃY KHỞI ĐỘNG LẠI MÁY ĐỂ VÀO I3 ===${NC}"
echo "Lưu ý: Bạn cần logout/login để Docker hoạt động không cần sudo."
