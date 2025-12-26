return {
  "amekusa/auto-input-switch.nvim",
  event = "InsertEnter", -- Hoặc sự kiện phù hợp
  config = function()
    require("auto-input-switch").setup({
      normalize = {
        enable = true, -- Luôn về tiếng Anh khi ở Normal mode
      },
      restore = {
        enable = true, -- Bật lại tiếng Việt khi vào Insert mode
      },
      -- Tính năng 'match' (tự động nhận diện ngôn ngữ xung quanh)
      -- có thể chưa hỗ trợ tốt tiếng Việt, nên có thể tắt đi để tránh lỗi.
      match = {
        enable = false,
      },
    })
  end,
}
