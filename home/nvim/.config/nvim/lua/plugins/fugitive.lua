return {
  "tpope/vim-fugitive",
  dependencies = {
    "tpope/vim-rhubarb", -- Plugin này giúp Fugitive hiểu link GitHub
  },
  cmd = "Git",
  keys = {
    { "<leader>G", "<cmd>Git<cr>", desc = "Git fugitive" },
  },
}
