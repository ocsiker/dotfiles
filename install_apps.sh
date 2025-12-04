#!/usr/bin/env bash
#doc tung file trong my_app

while read my_app; do
	if ! dpkg -l | grep -q "^ii $my_app"; then
		echo "install $my_app"
		sudo apt install -y $my_app
	else
		echo "$my_app is installed"
	fi
done <my_app

#    #!/bin/bash
#
## Đọc từng dòng trong file apps.txt và cài đặt từng ứng dụng
#while read app; do
#  if ! dpkg -l | grep -q "^ii  $app"; then  # Kiểm tra xem app đã cài chưa (dành cho hệ thống sử dụng dpkg, ví dụ Ubuntu, Debian)
#    echo "Cài đặt $app..."
#    sudo apt-get install -y $app  # Thực hiện cài đặt
#  else
#    echo "$app đã được cài đặt."
#  fi
#done < apps.txt
