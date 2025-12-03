return {
  -- lazy = false, --make snippets not load twice VERY IMPORTANT
  lazy = true, --make snippets not load twice VERY IMPORTANT
  version = "v2.2",
  build = "make install_jsregexp",
  "L3MON4D3/LuaSnip",
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function()
        -- require("luasnip.loaders.from_vscode").lazy_load()
        -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/Alpha/sourceCode/snippets/Jsnippets" } })
        -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
        -- IMPORTANT THING IS CHECK FILE PACKAGE.JSON IS AVAILABEL
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/Alpha/sourceCode/snippets/friendly-snippets" } })
      end,
    },
    {
      "honza/vim-snippets",
      -- require("luasnip.extras.snip_location").jump_to_snippet({ paths = { "~/Alpha/sourceCode/snippets/Jsnippets" } }),
      -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/Alpha/sourceCode/snippets/Jsnippets" } }),
      -- load snippets from path/of/your/nvim/config/my-cool-snippets
      --make run from snippets
      --make run from json vscode path with S paths
      --make run from snippets ---PATH not s just path
      require("luasnip.loaders.from_snipmate").load({ paths = { "~/Alpha/sourceCode/snippets/Hsnippets" } }),
    },
    --add file type
    require("luasnip").filetype_extend({ "uml" }, { "plantuml" }),
    require("luasnip").filetype_extend({ "sql" }, { "mysql" }),
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
