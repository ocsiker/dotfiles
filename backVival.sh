#!/bin/bash

# --- CẤU HÌNH ---
SOURCE="$HOME/.config/vivaldi/Default/Preferences"
DEST="$HOME/.config/vivaldi/Profile 1/Preferences"

# 1. Backup file đích trước khi làm
cp "$DEST" "$DEST.bak_workspaces"

echo "Đang copy Workspaces từ Default sang Profile 1..."

# 2. Lệnh COPY thần thánh
# Nó sẽ lấy toàn bộ object .vivaldi.workspaces bên nguồn đè vào bên đích
jq --slurpfile src "$SOURCE" '
  .vivaldi.workspaces = $src[0].vivaldi.workspaces
' "$DEST" >"$DEST.tmp" && mv "$DEST.tmp" "$DEST"

echo "✅ Đã chuyển xong! Mở Vivaldi lên để kiểm tra."
