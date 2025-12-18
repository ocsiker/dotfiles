return {
  "folke/flash.nvim",
  opts = {
    modes = {
      char = {
        jump_labels = true, -- Tùy chọn: Hiển thị nhãn khi dùng f, F, t, T
      },
    },
  },
  keys = {
    -- 1. Tắt phím 'r' mặc định của flash trong operator-pending mode
    -- Để nhường đường cho 'cr' của vim-abolish
    { "r", mode = "o", false },

    -- 2. Gán lại Remote Flash sang phím 'R' (Shift + ruj)
    -- Cách dùng mới: d + R + (nhãn) để xóa từ xa
    {
      "R",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "R",
      mode = "x",
      false,
    },
    -- Các phím s và S vẫn giữ nguyên mặc định của LazyVim, không cần khai báo lại
  },
}
