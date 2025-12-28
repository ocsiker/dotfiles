-- return {
--   {
--     "kristijanhusak/vim-dadbod-ui",
--     dependencies = {
--       { "tpope/vim-dadbod", lazy = true },
--       { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
--     },
--     cmd = {
--       "DBUI",
--       "DBUIToggle",
--       "DBUIAddConnection",
--       "DBUIFindBuffer",
--     },
--     init = function()
--       -- Your DBUI configuration
--       vim.g.db_ui_use_nerd_fonts = 1
--       vim.g.db_ui_auto_execute_table_helpers = 1
--       -- Enable Oracle Legacy Mode
--       vim.g.db_ui_is_oracle_legacy = 1
--       -- chay oracle sqlcl
--       vim.g.db_ui_use_sqlplus = 0
--       vim.g.dbext_default_ORA_bin = "sql"
--       --
--       vim.g.dbext_default_ORA_cmd = "sql -s"
--       --on which side of the screen should be drawer open
--       vim.g.db_ui_win_position = "right"
--       vim.g.db_ui_save_location = "~/Alpha/sourceCode/sql"
--     end,
--   },
-- }
return {
  -- 1. Plugin quản lý Database & UI
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "plsql", "mysql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- === CẤU HÌNH GIAO DIỆN ===
      vim.g.db_ui_use_nerd_fonts = 1 -- Dùng icon đẹp
      vim.g.db_ui_show_database_icon = 1

      -- === TỐI ƯU HIỆU NĂNG (QUAN TRỌNG) ===
      vim.g.db_ui_execute_on_save = 0 -- TẮT tự chạy query khi Save (tránh đơ máy)
      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_win_position = "right"
      vim.g.db_ui_save_location = "~/Alpha/sourceCode/sql"
      --
      -- NOTE:connect using common user c## to dba
      -- vim.g.dbs = {
      --   {
      --     name = "Oracle_Free_CUser",
      --     -- Lưu ý: Dùng nháy đơn ' ' bao bên ngoài để giữ nguyên nháy kép " " bên trong
      --     url = 'oracle://"C%23%23USER1":Ocs045027@localhost:1521/FREE',
      --   },
      -- }

      if vim.fn.executable("sqlplus") == 1 then
        -- Neovim sẽ ưu tiên dùng sqlplus có sẵn trong PATH
        -- Không cần trỏ đường dẫn cứng nếu bạn đã gõ được sqlplus trong terminal
      end
    end,
  },

  -- 2. Tích hợp Autocomplete vào nvim-cmp của LazyVim
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      -- Thêm nguồn gợi ý từ Dadbod vào danh sách sources
      -- Nó sẽ tự động hiện tên bảng/cột khi bạn gõ trong file SQL
      table.insert(opts.sources, { name = "vim-dadbod-completion" })

      -- (Tùy chọn) Sắp xếp lại thứ tự ưu tiên nếu cần
      -- Hiện tại để mặc định là ổn.
    end,
  },
}
