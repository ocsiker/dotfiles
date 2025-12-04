#!/bin/bash

dir="$HOME/.config/rofi/launchers/type-1"
theme='style-5'

function gen_workspaces() {
	i3-msg -t get_workspaces | tr ',' '\n' | grep "name" | sed 's/"name":"\(.*\)"/\1/g' | sort -n
}

WORKSPACE=$( (
	echo empty
	gen_workspaces
) | rofi -dmenu -p "Select workspace:" -theme ${dir}/${theme}.rasi)

if [ x"empty" = x"${WORKSPACE}" ]; then
	i3_empty_workspace.sh
elif [ -n "${WORKSPACE}" ]; then
	i3-msg workspace "${WORKSPACE}"
fi
