set $XDG_CONFIG_HOME=$HOME/.config/
set -o vi

case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
# [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

#run file from directory

if [ -f ~/bin/.bash_exports ]; then
	. ~/bin/.bash_exports
fi

if [ -f ~/bin/.bash_aliases ]; then
	. ~/bin/.bash_aliases
fi

if [ -f ~/bin/fzf.bash ]; then
	. ~/bin/fzf.bash
fi
#Fzf complete directory

if [ -f ~/bin/classPath.sh ]; then
	. ~/bin/classPath.sh
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# source /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

parse_git_branch() {
	git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Tự động rút gọn đường dẫn
export PROMPT_DIRTRIM=3

case "${HOSTNAME}" in
"mobile")
	# PS1 for mobile (laptop)
	export PS1="\[\e[35m\]🚙\[\e[32m\]\w\[\e[35m\]☆\[\e[91m\]\$(parse_git_branch)\[\e[00m\]\[\e[0m\]›\[\e[0m\]"
	;;
"home")
	# PS1 for home (PC)
	export PS1="\[\e[35m\]🐋\[\e[32m\]\w\[\e[35m\]☆\[\e[91m\]\$(parse_git_branch)\[\e[00m\]\[\e[0m\]›\[\e[0m\]"
	;;
"server")
	# PS1 for server
	export PS1="\[\e[36m\]🖥️\[\e[33m\]\w\[\e[36m\]☆\[\e[91m\]\$(parse_git_branch)\[\e[0m\]›\[\e[0m\]"
	;;
*)
	# PS1 mặc định của hệ thống (không thiết lập gì cả)
	;;
esac

# show title for the terminal
PROMPT_COMMAND='echo -ne "\033]0;$(basename ${PWD})\007"'
# Không phân biệt hoa thường khi tab completion
bind "set completion-ignore-case on"

# Hiển thị gợi ý ngay khi có nhiều lựa chọn (không cần tab 2 lần)
bind "set show-all-if-ambiguous on"

# Tự động thêm / vào cuối thư mục
bind "set mark-directories on"
bind "set mark-symlinked-directories on"

# Hoàn thành từng phần (như zsh)
bind "set menu-complete-display-prefix on"

# Hiển thị màu sắc cho các gợi ý
bind "set colored-stats on"

# Hiển thị loại file (*, /, @, =)
bind "set visible-stats on"

#bind phim tat de vao trong interactive cuar cheatsh
# Nhấn Ctrl + x rồi nhấn c để vào cheat.sh
# (Bash hạn chế phím tắt đơn hơn Zsh một chút để tránh xung đột)
bind '"\C-xc":"cht --shell\n"'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
