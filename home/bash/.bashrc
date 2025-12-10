# --- 1. CẤU HÌNH CƠ BẢN CỦA BASH ---

# Sửa lỗi cú pháp: dùng export thay vì set
export XDG_CONFIG_HOME="$HOME/.config/"

# Nếu không phải chế độ tương tác thì dừng ngay (để script chạy nhanh hơn)
case $- in
*i*) ;;
*) return ;;
esac
# Định nghĩa file lưu lịch sử
export HISTFILE="$HOME/.bash_history"
# Không lưu các lệnh trùng lặp hoặc bắt đầu bằng dấu cách vào lịch sử
HISTCONTROL=ignoreboth

# Nối thêm vào file lịch sử thay vì ghi đè
shopt -s histappend

# Kích thước lịch sử
HISTSIZE=100000
HISTFILESIZE=200000

# Cập nhật kích thước cửa sổ sau mỗi lệnh
shopt -s checkwinsize

# Thiết lập chroot (nếu có)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# Màu sắc terminal
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# --- 2. LOAD CÁC FILE CẤU HÌNH PHỤ ---

if [ -f ~/.bash_exports ]; then
	. ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Chạy các option cho fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
if [ -f ~/bin/fzf.bash ]; then
	. ~/bin/fzf.bash
fi

if [ -f ~/bin/classPath.sh ]; then
	. ~/bin/classPath.sh
fi

# Bật tính năng completion có sẵn của hệ thống
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi
#
# Kích hoạt gợi ý Git thủ công
if [ -f ~/.git-completion.bash ]; then
	. ~/.git-completion.bash
fi
# --- 3. CẤU HÌNH GIAO DIỆN (PROMPT) ---
parse_git_branch() {
	git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PROMPT_DIRTRIM=3

# Mã màu chuẩn: \033 = ESC
# \033[35m = Màu tím
# \033[32m = Màu xanh lá
# \033[91m = Màu đỏ sáng
# \033[0m  = Reset màu

case "${HOSTNAME}" in
"mobile")
	export PS1="\[\033[35m\]🚙\[\033[32m\]\w\[\033[35m\]☆\[\033[91m\]\$(parse_git_branch)\[\033[0m\]›\[\033[0m\] "
	;;
"home")
	export PS1="\[\033[35m\]🐋\[\033[32m\]\w\[\033[35m\]☆\[\033[91m\]\$(parse_git_branch)\[\033[0m\]›\[\033[0m\] "
	;;
"server")
	export PS1="\[\033[36m\]🖥️\[\033[33m\]\w\[\033[36m\]☆\[\033[91m\]\$(parse_git_branch)\[\033[0m\]›\[\033[0m\] "
	;;
*)
	# Mặc định cho các máy khác
	export PS1="\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[91m\]\$(parse_git_branch)\[\033[0m\]\$ "
	;;
esac

# Tiêu đề cửa sổ
PROMPT_COMMAND='echo -ne "\033]0;$(basename ${PWD})\007"'

# --- 4. CÁC TÙY CHỌN BIND KEY ---
# Lưu ý: Một số lệnh bind có thể bị ble.sh ghi đè, nhưng vẫn giữ lại để tương thích

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
bind "set mark-directories on"
bind "set mark-symlinked-directories on"
bind "set menu-complete-display-prefix on"
bind "set colored-stats on"
bind "set visible-stats on"

# --- 5. KHỞI ĐỘNG BLE.SH (ĐỂ CUỐI CÙNG) ---
# Đặt ở cuối để đảm bảo mọi biến môi trường đã sẵn sàng
[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh
