return {
  "sontungexpt/vietnamese.nvim",
  lazy = false,
  dependencies = {
    "sontungexpt/bim.nvim",
  },
  config = function()
    -- Setup plugin
    require("vietnamese").setup({
      enabled = true, -- Mặc định bật khi mở máy
      input_method = "telex",
      orthography = "modern",
      excluded = {},
      custom_methods = {},
    })

    -- 1. Tự tạo biến toàn cục để theo dõi trạng thái (Vì plugin không cho API check)
    vim.g.vietnamese_enabled = true

    -- 2. Hàm Toggle sửa lỗi
    local function toggle_vn()
      -- THAY ĐỔI QUAN TRỌNG: Gọi lệnh Vim command thay vì hàm Lua bị lỗi
      vim.cmd("VietnameseToggle")

      -- Đảo ngược trạng thái biến theo dõi của mình
      vim.g.vietnamese_enabled = not vim.g.vietnamese_enabled

      -- Force Lualine cập nhật lại ngay lập tức
      local ok, lualine = pcall(require, "lualine")
      if ok then
        lualine.refresh()
      end

      -- Hiển thị thông báo
      if vim.g.vietnamese_enabled then
        vim.notify("Đã BẬT Tiếng Việt", vim.log.levels.INFO, { title = "Bộ gõ" })
      else
        vim.notify("Đã TẮT Tiếng Việt (English)", vim.log.levels.WARN, { title = "Bộ gõ" })
      end
    end

    -- 3. Map phím
    vim.keymap.set("n", "<C-u>", toggle_vn, { desc = "Bật/Tắt Tiếng Việt" })
    vim.keymap.set("i", "<C-u>", toggle_vn, { desc = "Bật/Tắt Tiếng Việt" })
  end,
}
