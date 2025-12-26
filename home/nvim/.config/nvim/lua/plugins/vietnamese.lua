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
    -- 2. Gán phím thủ công bằng vim.keymap.set (Ổn định hơn)
    -- Gán cho Normal Mode
    vim.keymap.set("n", "<C-h>", "<cmd>VietnameseToggle<CR>", { desc = "Bật/Tắt Tiếng Việt" })

    -- Gán cho Insert Mode (Cho phép vừa gõ vừa tắt)
    vim.keymap.set("i", "<C-h>", "<cmd>VietnameseToggle<CR>", { desc = "Bật/Tắt Tiếng Việt" })
  end,
}
