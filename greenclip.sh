#!/usr/bin/env bash
mkdir -p /tmp/greenclip
cd /tmp/greenclip
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip

chmod +x greenclip

sudo mv greenclip /usr/local/bin/
