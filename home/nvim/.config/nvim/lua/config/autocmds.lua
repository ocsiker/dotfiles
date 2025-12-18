-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- load folding

vim.api.nvim_create_autocmd("BufWinLeave", {
  callback = function()
    if vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("mkview!")
    end
  end,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    if vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! loadview")
      vim.cmd("normal! zx")
    end
  end,
})

vim.api.nvim_create_augroup("PLSQLComment", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "PLSQLComment",
  pattern = { "plsql", "sql" }, -- Áp dụng cho file PL/SQL và SQL
  callback = function()
    vim.bo.commentstring = "-- %s"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "plsql" },
  callback = function()
    vim.b.autoformat = false
  end,
})
