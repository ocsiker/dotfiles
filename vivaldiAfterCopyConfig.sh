#!/bin/bash
#
# xoa nhung file khong can thiet de chay duoc config cua vivaldi
cd $HOME
rm -rf .config/vivaldi/Singleton* .config/vivaldi/Default/GPUCache .config/vivaldi/ShaderCache .config/vivaldi/Default/Login\ Data .config/vivaldi/Default/Login\ Data-journal .config/vivaldi/Default/{Cookies,Cookies-journal}

bash $HOME/dotfiles/preference.sh
