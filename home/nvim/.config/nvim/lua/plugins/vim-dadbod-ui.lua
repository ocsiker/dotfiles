return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_auto_execute_table_helpers = 1
      -- Enable Oracle Legacy Mode
      vim.g.db_ui_is_oracle_legacy = 1
      -- chay oracle sqlcl
      vim.g.db_ui_use_sqlplus = 0
      vim.g.dbext_default_ORA_bin = "sql"
      --
      vim.g.dbext_default_ORA_cmd = "sql -s"
      --on which side of the screen should be drawer open
      vim.g.db_ui_win_position = "right"
      vim.g.db_ui_save_location = "~/Alpha/sourceCode/sql"
    end,
  },
}
