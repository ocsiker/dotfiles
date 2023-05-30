return {
  "github/copilot.vim",
  cmd = "Copilot",
  event = { "BufReadPost", "BufNewFile" },
  init = function()
    vim.g.copilot_no_tab_remap = false
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_filetypes = {
      ["*"] = true,
      TelescopeResults = false,
      TelescopePrompt = false,
    }
  end,
}
