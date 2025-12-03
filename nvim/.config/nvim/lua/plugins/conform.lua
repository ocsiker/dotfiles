return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      sql = { "pg_format" },
      plsql = { "pg_format" },
    },
    formatters = {
      pg_format = {
        command = "pg_format",
        args = { "$FILENAME", "-o", "$FILENAME" }, -- Ghi đè file gốc
        stdin = false,
      },
    },
  },
  -- config = function(_, opts)
  --   require("conform").setup(opts)
  --   -- Thêm bước sed để xuống dòng sau ;
  --   vim.api.nvim_create_autocmd("BufWritePost", {
  --     pattern = "*.sql",
  --     callback = function()
  --       vim.fn.system("sed -i 's/;/;\\n/g' " .. vim.fn.expand("%"))
  --       vim.cmd("e!") -- Reload file sau khi sed chạy
  --     end,
  --   })
  -- end,
}
