return {
  "sontungexpt/vietnamese.nvim",
  lazy = false,
  dependencies = {
    "sontungexpt/bim.nvim", -- Dependency bắt buộc
  },
  config = function()
    require("vietnamese").setup({
      -- Các tùy chọn cấu hình:
      enabled = true, -- Bật/tắt plugin
      input_method = "telex", -- Chọn bộ gõ: "telex", "vni", hoặc "viqr"
      orthography = "modern", -- Kiểu bỏ dấu: "modern" (hòa) hoặc "old" (hoà)
    })
  end,
}
