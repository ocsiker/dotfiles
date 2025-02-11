#!/usr/bin/env bash

echo "Khôi phục danh sách gói PPA"
sudo cp ./ppa.list /etc/apt/sources.list.d/
sudo apt update

echo "Khôi phục danh sách packages"
sudo dpkg --set-selections <./packages.list
sudo apt dselect-upgrade -y
