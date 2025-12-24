-- sqlfluff:ignore
-- --- CONFIG ---
SET SQLFORMAT ansiconsole
SET PAGESIZE 1000
SET LINESIZE 300
SET HISTORY limit 5000

-- --- ALIASES ---
-- Thay vì viết dài dòng, Alias này chỉ gọi file fzf_run.sql ta tạo ở Bước 1
ALIAS pick=@~/.sqlcl/fzf_run.sql

-- Alias edit nhanh
ALIAS fzed=HOST ~/.sqlcl/pick_sql.sh

-- Reload
ALIAS reload=@~/.sqlcl/login.sql
ALIAS cls=CLEAR SCREEN

alias whoami=select sys_context('userenv','con_name') con, user from dual;
-- --- PROMPT (PDB Name) ---
COLUMN current_pdb NEW_VALUE _my_pdb NOPRINT
SELECT sys_context('userenv', 'con_name') AS current_pdb FROM dual;
SET SQLPROMPT "_USER@&_my_pdb > "
