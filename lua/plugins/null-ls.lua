return {
  "jose-elias-alvarez/null-ls.nvim",
  -- event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },
  opts = function()
    local nls = require("null-ls")
    return {
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
      sources = {
        nls.builtins.formatting.fish_indent,
        nls.builtins.diagnostics.fish,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.sqlfmt,
        nls.builtins.formatting.sqlformat,
        nls.builtins.formatting.sql_formatter,
        -- nls.builtins.diagnostics.flake8,
        nls.builtins.formatting.dart_format,
        nls.builtins.formatting.swiftlint,
        nls.builtins.formatting.clang_format,
        nls.builtins.formatting.google_java_format,
        nls.builtins.formatting.rustywind.with({ extra_filetypes = { "rust", "elixir" } }),
        nls.builtins.completion.spell,
        nls.builtins.diagnostics.commitlint,
        nls.builtins.diagnostics.shellcheck,
        nls.builtins.completion.spell,
        nls.builtins.completion.luasnip,
        nls.builtins.hover.dictionary,
      },
    }
  end,
}
