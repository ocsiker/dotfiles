return {
  {
    "honza/vim-snippets",
    require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/Alpha/sourceCode/snippets/" } }),
  },
}
