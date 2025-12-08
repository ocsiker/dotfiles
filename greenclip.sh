#!/usr/bin/env bash

if [ -f /tmp/greenclip ]; then
	rm -rf /tmp/greenclip
fi

# Tải trực tiếp về /usr/local/bin
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip -O /tmp/greenclip
chmod +x /tmp/greenclip
sudo mv /tmp/greenclip /usr/local/bin/
