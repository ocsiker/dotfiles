alias vim='nvim'
alias pwo='poweroff'
alias python=python3
alias rsync='rsync --stats --progress'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# Thay thế ls bằng eza với icon và màu sắc
alias ls='eza --icons --group-directories-first'
alias ll='eza --icons -la --group-directories-first'
alias tree='eza --icons --tree'
