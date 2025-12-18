return {
  "gregorias/coerce.nvim",
  tag = "v4.1.0", -- NÊN GIỮ: Để cố định phiên bản ổn định, tránh lỗi khi tác giả update code mới

  --  Cách sư ử（dụng là bấm gw {s, k,p} và W để chọn từ cần chuyển phải có motion cuối cùng là w
  --  hay E hay e gì cũng được
  -- Phần này dành cho LazyVim để load nhanh và đúng phím v  MY_VAR_NUMBER
  keys = {
    { "gw", mode = { "n", "v" }, desc = "Coerce Case" },
  },

  -- KHÔNG DÙNG 'config = true' mà dùng function để setup phím gw
  config = function()
    require("coerce").setup({
      default_mode_keymap_prefixes = {
        normal_mode = "gw",
        motion_mode = "gw",
        visual_mode = "gw",
      },
    })
  end,
}
