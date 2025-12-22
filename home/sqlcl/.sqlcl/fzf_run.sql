-- 1. Gọi script shell để chọn file (Script này sẽ tạo/ghi đè file run_buffer.sql)
HOST ~/.sqlcl/pick_and_run.sh

-- 2. Chạy file kết quả vừa được tạo ra
@~/.sqlcl/run_buffer.sql
