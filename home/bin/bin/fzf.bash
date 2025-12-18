# Biến này chứa các thư mục cần bỏ qua để dễ dàng tái sử dụng
FZF_EXCLUDE="\( -name 'node_modules' -o -name '.git' -o -name '.npm' -o -name 'ora_data' -o -name 'snap' -o -name 'thorium' \) -prune"

# Lệnh tìm kiếm mặc định, bỏ qua các thư mục trong FZF_EXCLUDE
export FZF_DEFAULT_COMMAND="find . -mindepth 1 $FZF_EXCLUDE -o -print"

# Lệnh cho Ctrl+T cũng tương tự
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--multi --preview "
    if [ -d {} ]; then
      echo {} is directory
    elif file --mime-encoding {} | grep -q binary; then
      # Nếu là file binary, chỉ hiển thị thông báo
      echo {} is a binary file.
    else
      # Nếu là file text, dùng batcat
      batcat --color=always --style=numbers --line-range=:200 {}
    fi
"'
