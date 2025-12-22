#!/bin/bash
# Tìm file sql, loại bỏ lỗi permission, hiển thị fzf đẹp
TARGET=$(find . -maxdepth 4 -name "*.sql" 2>/dev/null | fzf --preview 'head -20 {}' --height 50% --layout=reverse --border --prompt="SQL> ")

# Nếu chọn được file (TARGET không rỗng) thì mở nvim
if [ -n "$TARGET" ]; then
	nvim "$TARGET"
fi
