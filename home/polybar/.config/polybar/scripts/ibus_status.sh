#!/bin/bash

# Lấy tên engine hiện tại
ENGINE=$(ibus engine)

# Kiểm tra và hiển thị icon/chữ tương ứng
if [[ "$ENGINE" == *"Bamboo"* ]]; then
	# Nếu đang dùng Bamboo (Tiếng Việt)
	echo "VN"
else
	# Các trường hợp còn lại (Tiếng Anh - xkb:us::eng)
	echo "EN"
fi
