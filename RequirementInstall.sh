#!/bin/bash

sudo apt install ranger
sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3

sudo apt install build-essential cmake vim-nox python3-dev

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


echo "Install Curl"
echo "_________________________________________"
sudo apt install curl

echo "Install Plugged"
echo "_________________________________________"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


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

echo "Install tmux"
echo "_________________________________________"
sudo apt install autoconf pkg-config automake libevent-dev ncurses-dev build-essential bison
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure && make

echo "Intall llvm ccls"
sudo apt install llvm
sudo apt install ccls

echo "install blueman for bluetooth"
# link tham khao https://www.nielsvandermolen.com/bluetooth-headphones-ubuntu/
sudo apt-get install blueman

#install google translate from desktop 
#link tutorial for this https://www.youtube.com/watch?v=zOKZdNvLuKE&ab_channel=ErrorAndFix
sudo apt-get install libnotify-bin wget xsel
# next do stream on youtube

#translate-shell
sudo apt install translate-shell

#tlp
sudo apt install tlp tlp-rdw
sudo tlp start

#infor disk
sudo apt install smartmontools

#display battery percentage in linux 
gsettings set org.gnome.desktop.interface show-battery-percentage true

#install tizonia to play youtube spotify tuneIn on terminal

# Step1: update Tizonia's Debian packages
sudo apt-get update && sudo apt-get upgrade

# Step2: update Tizonia's Python dependencies
# (Note that new versions of some of these Python dependencies are released often,
# so you should do this frequently, even if there isn't a new Tizonia release)

# For Tizonia v0.19.0 or newer: Python 3 dependencies
sudo -H pip3 install --upgrade gmusicapi soundcloud youtube-dl pafy pycountry titlecase pychromecast plexapi spotipy fuzzywuzzy eventlet python-Levenshtein

sudo apt install heif-gdk-pixbuf -y
