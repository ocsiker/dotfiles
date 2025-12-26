return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local vn_component = {
        function()
          -- Đọc biến toàn cục mà ta đã set bên file kia
          if vim.g.vietnamese_enabled then
            return "VN"
          end
          return "EN"
        end,
        color = { fg = "#ff9e64", gui = "bold" },
      }

      -- Chèn vào lualine_x (bên phải)
      table.insert(opts.sections.lualine_x, 1, vn_component)
    end,
  },
}
