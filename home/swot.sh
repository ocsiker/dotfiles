#!/bin/bash 
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Thư mục đích để tạo symlink (thường là Home)
TARGET_DIR="$HOME"

# Danh sách các package bạn muốn stow (tên các folder trong dotfiles)
# Bạn có thể thêm hoặc bớt tùy nhu cầu
PACKAGES=(
    "git"
    "nvim"
    "rofi"
    "polybar"
    "cmus"
    "bash"
    "bin"
    "alacritty"
    # "scripts"
)

# --- XỬ LÝ ---

echo "Đang tiến hành stow các file từ $DOTFILES_DIR tới $TARGET_DIR..."

for package in "${PACKAGES[@]}"; do
    if [ -d "$DOTFILES_DIR/$package" ]; then
        echo "--> Stowing: $package"
        # -v: verbose (hiện chi tiết)
        # -R: restow (tự động xóa link cũ và cập nhật link mới - rất hữu ích)
        # -t: target (đích đến)
        stow -v -R -t "$TARGET_DIR" "$package"
    else
        echo "!! Cảnh báo: Không tìm thấy folder $package, bỏ qua."
    fi
done

echo "--- Hoàn tất! ---"
