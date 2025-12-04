-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.o.background = "dark" -- or "light" for light mode
vim.o.foldmethod = "manual"
vim.o.foldlevel = 0
vim.o.foldenable = true
-- vim.o.foldclose = "all"
vim.o.foldlevelstart = 0
-- remap localleader for nvim
vim.g.maplocalleader = ","
-- tự động ngắt dòng khi 80 ý tự
vim.o.textwidth = 100
-- them title de hien thi trong tmux
vim.opt.title = true
vim.opt.titlestring = "%t %m"
