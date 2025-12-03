return {
  "atiladefreitas/dooing",
  config = function()
    require("dooing").setup({
      -- Priority settings
      scratchpad = {
        syntax_highlight = "markdown",
      },

      priorities = {
        {
          name = "Critical",
          weight = 1,
        },
        {
          name = "urgent",
          weight = 2,
        },
        {
          name = "important",
          weight = 3,
        },
        {
          name = "soon",
          weight = 4,
        },
        {
          name = "minor",
          weight = 5,
        },
        {
          name = "later",
          weight = 6,
        },
      },
      priority_groups = {
        critical = {
          members = { "Critical" },
          color = "#FF0000", -- Đỏ (Critical, cao nhất)
          hl_group = nil,
        },
        urgent = {
          members = { "urgent" },
          color = "#FF7F7F", -- Đỏ nhạt (Urgent, khẩn cấp)
          hl_group = nil,
        },
        important = {
          members = { "important" },
          color = "#FFD700", -- Vàng (Soon, sớm)
          hl_group = nil,
        },
        soon = {
          members = { "soon" },
          color = "#FFA500", -- Cam (Important, quan trọng)
          hl_group = nil,
        },
        minor = {
          members = { "minor" },
          color = "#ADD8E6", -- Xanh dương nhạt (Minimal Priority)
          hl_group = nil,
        },
        later = {
          members = { "later" },
          color = "#808080", -- Xám (Minor, ít quan trọng)
          hl_group = nil,
        },
      },
      -- your custom config here (optional)
    })
  end,
}
