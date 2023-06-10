return {
  lazy = false, --make snippets not load twice VERY IMPORTANT
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
    --make run from snippets
    "honza/vim-snippets",
    --make run from json vscode path with S paths
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/Alpha/sourceCode/snippets/Jsnippets" } }),
    --make run from snippets ---PATH not s just path
    require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/Alpha/sourceCode/snippets/Hsnippets" } }),
    --add file type
    require("luasnip").filetype_extend({ "uml" }, { "plantuml" }),
  },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
    enable_autosnippets = true,
    vim.cmd("command! LuaSnipEdit lua require('luasnip.loaders').edit_snippet_files()"),
    vim.cmd("command! LuaSnipStart lua require('luasnip')"),
  },
  -- stylua: ignore
}
