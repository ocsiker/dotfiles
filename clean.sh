#!/bin/bash
sudo apt autoremove
sudo rm -rf ~/.cache/thumbnails/*
du -sh ~/.cache/thumbnails
sudo du -sh /var/cache/apt
sudo apt-get clean
