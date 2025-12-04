#!/bin/bash

# Tìm tất cả thư mục con trong java/, nối lại bằng dấu hai chấm (:), bỏ lỗi nếu thư mục không tồn tại
if [ -d "$HOME/Alpha/sourceCode/java" ]; then
    export CLASSPATH=$(find "$HOME/Alpha/sourceCode/java" -type d -printf "%p:")
fi
