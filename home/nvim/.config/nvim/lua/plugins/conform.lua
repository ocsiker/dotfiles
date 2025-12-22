return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Khai báo file sql dùng sqlfluff
        sql = { "sqlfluff" },
        plsql = { "sqlfluff" },
      },
      formatters = {
        sqlfluff = {
          -- "fix" để sửa lỗi
          -- "--dialect oracle" để hiểu cú pháp Oracle
          -- "-" là ký hiệu báo cho tool đọc từ stdin (bộ nhớ đệm của Neovim)
          args = { "fix", "--dialect", "oracle", "-" },
          stdin = true, -- Quan trọng: Cho phép neovim gửi code qua luồng input
        },
      },
    },
  },
}
