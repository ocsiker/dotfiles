-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "g/", function()
  local dir = vim.fn.expand("%:p:h") -- Lấy đường dẫn thư mục của file hiện tại (an toàn hơn %:p:h trong cmd)
  if dir == "" then
    vim.notify("No file open, cannot change directory.", vim.log.levels.WARN)
    return
  end
  vim.cmd("lcd " .. vim.fn.fnameescape(dir)) -- Chạy lcd, escape path nếu cần (an toàn với ký tự đặc biệt)
  vim.notify("Changed to directory: " .. dir, vim.log.levels.INFO) -- Hiển thị thông báo
end, { desc = "change to dir of current file" })

vim.keymap.set("n", "<leader>fk", function()
  require("adoc_search").search_adoc_keywords()
end, { desc = "Search AsciiDoc keywords with fzf" })

local keymaps = {
  "config.keymaps.asciidoc",
}

for _, mod in ipairs(keymaps) do
  local ok, err = pcall(require, mod)
  if not ok then
    vim.notify("Lỗi khi load keymap: " .. mod .. "\n" .. err, vim.log.levels.ERROR)
  end
end
