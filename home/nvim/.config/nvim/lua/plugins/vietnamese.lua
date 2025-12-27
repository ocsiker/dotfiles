return {
  "sontungexpt/vietnamese.nvim",
  lazy = false,
  dependencies = {
    "sontungexpt/bim.nvim",
  },
  config = function()
    -- 1. Setup Plugin
    require("vietnamese").setup({
      enabled = true,
      input_method = "telex",
      orthography = "modern",
      excluded = {},
      custom_methods = {},
    })

    -- 2. Khởi tạo biến trạng thái (Quan trọng để Lualine đọc)
    vim.g.vietnamese_enabled = true

    -- 3. Tạo một hàm Global (Toàn cục) chỉ để cập nhật giao diện
    -- (Ta dùng _G để có thể gọi nó từ chuỗi phím tắt bên dưới)
    _G.update_vn_ui = function()
      -- Đảo ngược trạng thái biến của mình
      vim.g.vietnamese_enabled = not vim.g.vietnamese_enabled

      -- Refresh Lualine
      local ok, lualine = pcall(require, "lualine")
      if ok then
        lualine.refresh()
      end

      -- Thông báo (Optional)
      if vim.g.vietnamese_enabled then
        vim.notify("VN", vim.log.levels.INFO, { title = "Bộ gõ" })
      else
        vim.notify("EN", vim.log.levels.WARN, { title = "Bộ gõ" })
      end
    end

    -- 4. Map phím theo kiểu "Kẹp thịt" (Chaining)
    -- Nó sẽ chạy lệnh Toggle gốc trước -> Sau đó chạy lệnh Lua để update UI
    local map_cmd = "<cmd>VietnameseToggle<CR><cmd>lua _G.update_vn_ui()<CR>"

    vim.keymap.set("n", "<C-i>", map_cmd, { desc = "Bật/Tắt Tiếng Việt" })
    vim.keymap.set("i", "<C-i>", map_cmd, { desc = "Bật/Tắt Tiếng Việt" })
  end,
}
