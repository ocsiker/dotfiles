#  ashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# Append this line to ~/.bashrc to enable fzf keybindings for Bash:
# make color in terminal right
# source key-bindings.basho

export PATH="$HOME/bin:$PATH"
# export PATH="/usr/lib/jvm/java-17-openjdk-amd64/bin/:$PATH"
export PATH="/usr/lib/jvm/java-1.17.0-openjdk-amd64/bin/:$PATH"
export PATH="/opt/gradle/gradle-8.1.1/bin/:$PATH:$HOME/.local/bin/"
#kkjukjkjkj:q for classpath in linux
# export CLASSPATH=
source /usr/share/doc/fzf/examples/key-bindings.bash
# source ~/bin/completion.bash
# source /usr/share/doc/fzf/examples/completion.bash
# Append this line to ~/.bashrc to enable fuzzy auto-completion for Bash:
# show hidden file in fzf
source ~/bin/fzf.bash
# jump back in fzf
# source ~/bin/fzf-jump.bash
#change color directory when wrong display color
# source ~/bin/lsColor

# If not running interactively, don't do anything

set $XDG_CONFIG_HOME=$HOME/.config/
set -o vi
alias vim='nvim'
alias pwo='poweroff'
alias python=python3
alias rsync='rsync --stats --progress'
alias ls='lsd'
alias ll='ls -alF '
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
HISTSIZE=1000
HISTFILESIZE=2000

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

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

#Fzf complete directory

if [ -f ~/classPath.sh ]; then
	. ~/classPath.sh
fi

if [ -f ~/makeMoveEasier.sh ]; then
	. ~/makeMoveEasier.sh
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

if [ "${HOSTNAME}" = 'mobile' ]; then
	# $PS1 for laptop
	# 35m purple ∴
	# \w là cho đường dẫn
	export PS1="\[\e[35m\]🚙 \[\e[32m\]\w\[\e[35m\]☆\[\e[91m\]\$(parse_git_branch)\[\e[00m\]✔️"

else
	# $PS1 for pc
	[ "${HOSTNAME}" = 'home' ]
	# 35m purple √ ☆
	export PS1="\[\e[35m\]🐋\[\e[32m\]\w\[\e[35m\]☆\[\e[91m\]\$(parse_git_branch)\[\e[00m\]✔️"
fi

# show title for the terminal
PROMPT_COMMAND='echo -ne "\033]0;$(basename ${PWD})\007"'

# export OPENAI_API_KEY=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
# Add FFMpeg bin & library paths:
export PATH=/usr/local/ffmpeg/bin:/opt/gradle/gradle-8.1.1/bin/:/usr/lib/jvm/java-1.17.0-openjdk-amd64/bin/:/home/ocsiker/bin:/opt/gradle/gradle-8.1.1/bin/:/usr/lib/jvm/java-1.17.0-openjdk-amd64/bin/:/home/ocsiker/bin:/opt/maven/bin:/opt/gradle/latest/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/lib/jvm/java-1.17.0-openjdk-amd64//bin:/usr/local/go/bin
export LD_LIBRARY_PATH=/usr/local/ffmpeg/lib:
# Add FFMpeg bin & library paths:
export PATH=/usr/local/ffmpeg/bin:/usr/local/ffmpeg/bin:/opt/gradle/gradle-8.1.1/bin/:/usr/lib/jvm/java-1.17.0-openjdk-amd64/bin/:/home/ocsiker/bin:/opt/gradle/gradle-8.1.1/bin/:/usr/lib/jvm/java-1.17.0-openjdk-amd64/bin/:/home/ocsiker/bin:/opt/maven/bin:/opt/gradle/latest/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/lib/jvm/java-1.17.0-openjdk-amd64//bin:/usr/local/go/bin
export LD_LIBRARY_PATH=/usr/local/ffmpeg/lib:/usr/local/ffmpeg/lib:
