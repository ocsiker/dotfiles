#!/usr/bin/env bash

rsync -ra --update --stats --progress --exclude={'.config/google-chrome','.cargo','.cache','.npm','.gnupg','.local','.ssh','.m2','.mozilla'} ~/Alpha/backupDotfiles/ .
