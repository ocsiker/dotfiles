#!/bin/bash
FILE_TEMP="$HOME/.sqlcl/run_buffer.sql"
SELECTION_TEMP="/tmp/sqlcl_fzf_selection"

# 1. Reset buffer
echo "PROMPT [INFO] No file selected." >"$FILE_TEMP"

# 2. Tìm file (Đã tối ưu để bỏ qua file ẩn và thư mục rác)
find . -type f -name "*.sql" -not -path '*/.*' -not -path '*/target/*' |
	fzf --height 40% --layout=reverse --border --prompt="RUN SQL > " \
		>"$SELECTION_TEMP" </dev/tty

# 3. Xử lý kết quả
if [ -s "$SELECTION_TEMP" ]; then
	SELECTED_FILE=$(cat "$SELECTION_TEMP")
	ABS_PATH=$(realpath "$SELECTED_FILE")

	echo "PROMPT Executing: $ABS_PATH" >"$FILE_TEMP"
	echo "@$ABS_PATH" >>"$FILE_TEMP"
else
	echo "PROMPT [CANCEL] Selection cancelled." >"$FILE_TEMP"
fi

rm -f "$SELECTION_TEMP"
