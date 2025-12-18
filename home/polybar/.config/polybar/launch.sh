#!/usr/bin/env bash
# Kết thúc các instance Polybar đang chạy
polybar-msg cmd quit

# Đợi cho đến khi các tiến trình Polybar được kết thúc
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Sử dụng xrandr để lấy danh sách các màn hình kết nối
if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar --reload mybar &
	done
else
	polybar --reload mybar &
fi

echo "Polybar đã được khởi chạy trên các màn hình."
