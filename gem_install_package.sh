#!/usr/bin/env bash

# Cấu hình tên file
#
INPUT_FILE="/home/ocsiker/dotfiles/gems_backup.txt"

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Khôi phục Ruby Gems từ file $INPUT_FILE==="

if [ ! -f "$INPUT_FILE" ]; then
	echo -e "${RED}Lỗi: Không tìm thấy file $INPUT_FILE tại thư mục hiện tại"
	exit 1
fi

if ! command -v gem &>/dev/null; then
	echo -e "${RED}Lỗi: Ruby chưa được cài đặt"
	exit 1
fi

SUCCESS_COUNT=0
FAIL_COUNT=0

# 3. Đọc từng dòng và cài đặt
while IFS= read -r gem_name || [ -n "$gem_name" ]; do
	# Bỏ qua dòng trống hoặc dòng bắt đầu bằng #
	[[ -z "$gem_name" || "$gem_name" =~ ^# ]] && continue

	# Loại bỏ khoảng trắng thừa
	gem_name=$(echo "$gem_name" | xargs)

	echo -n "Đang cài đặt: $gem_name ... "

	# Chạy lệnh cài đặt (Thêm --no-document để cài nhanh hơn, bỏ qua docs)
	if gem install "$gem_name" --no-document >/dev/null 2>&1; then
		echo -e "${GREEN}[OK]${NC}"
		((SUCCESS_COUNT++))
	else
		echo -e "${RED}[FAILED]${NC}"
		echo " -> Có thể gem này là mặc định hệ thống hoặc cần thư viện C (như mysql, pg)."
		((FAIL_COUNT++))
	fi

done <"$INPUT_FILE"
#
# 4. Tổng kết
echo "------------------------------------------------"
echo -e "Hoàn tất!"
echo -e "Thành công: ${GREEN}$SUCCESS_COUNT${NC}"
echo -e "Thất bại:   ${RED}$FAIL_COUNT${NC}"
echo "------------------------------------------------"
