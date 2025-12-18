return {
  "pwntester/octo.nvim",
  opts = function(_, opts)
    vim.treesitter.language.register("markdown", "octo")
    if LazyVim.has_extra("editor.telescope") then
      opts.picker = "telescope"
    elseif LazyVim.has_extra("editor.fzf") then
      opts.picker = "fzf-lua"
    elseif LazyVim.has_extra("editor.snacks_picker") then
      opts.picker = "snacks"
    else
      LazyVim.error("`octo.nvim` requires `telescope.nvim` or `fzf-lua` or `snacks.nvim`")
    end

    -- Keep some empty windows in sessions
    vim.api.nvim_create_autocmd("ExitPre", {
      group = vim.api.nvim_create_augroup("octo_exit_pre", { clear = true }),
      callback = function(ev)
        local keep = { "octo" }
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.tbl_contains(keep, vim.bo[buf].filetype) then
            vim.bo[buf].buftype = "" -- set buftype to empty to keep the window
          end
        end
      end,
    })
  end,
}
