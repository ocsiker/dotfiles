alias vim='nvim'
alias pwo='poweroff'
alias python=python3
alias rsync='rsync --stats --progress'
alias ll='ls -alhsF '
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
