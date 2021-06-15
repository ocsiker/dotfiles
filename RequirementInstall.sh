#!/bin/bash

sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3


echo "Install IBUS-BAMBOO"
echo "_________________________________________"
sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
sudo apt-get update
sudo apt-get install ibus-bamboo
ibus restart
# Đặt ibus-bamboo làm bộ gõ mặc định
env DCONF_PROFILE=ibus dconf write /desktop/ibus/general/preload-engines "['xkb:us::eng', 'Bamboo']" && gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'Bamboo')]"

echo "Install TMUX"
echo "_________________________________________"
sudo apt instal tmux


echo "Install Alacritty"
echo "_________________________________________"

sudo add-apt-repository ppa:aslatter/ppa
sudo apt install alacritty


echo "Install Clipboard to paste from Vim to external Program"
echo "_________________________________________"
# https://vi.stackexchange.com/questions/84/how-can-i-copy-text-to-the-system-clipboard-from-vim/96#96

sudo apt install xclip xsel


echo "Install Fuse and ntfs-3g to mount disk ntfs"
echo "_________________________________________"

sudo apt install fuse ntfs-3g



echo "Install Nodejs"
echo "_________________________________________"
sudo apt-get install nodejs
sudo apt-get install npm
sudo npm cache clean -f
sudo npm install -g n
sudo n stable

#for all require YCM cannot use IN NEOVIM
sudo apt install mono-complete golang nodejs default-jdk npm 
sudo apt-get install python-dev

#dung python trong neovim
sudo apt install python3-pip
pip3 install pynvim
pip3 install --upgrade pynvim
python3 -m pip install pynvim
# sau do dung trong link https://github.com/vim-autoformat/vim-autoformat de xem
# chi tiet

