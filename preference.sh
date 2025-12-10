#!/usr/bin/env bash
# 5.4 Sao chép preference để load lại các rules cho vivaldi
if [ -f "system/Preferences" ]; then
	echo "    - Restore cấu hình rules cho vivaldi..."
	cp system/Preferences $HOME/.config/vivaldi/Default/Preferences
fi
