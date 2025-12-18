return {
  "pwntester/octo.nvim",
  opts = {
    mappings = {
      review_diff = {
        -- 1. Map lại phím Add Comment (tránh xung đột với ca của mini.ai)
        add_comment = { lhs = "<leader>ac", desc = "Add Comment" },

        -- Map thêm phím xóa comment nếu cần
        delete_comment = { lhs = "<leader>dc", desc = "Delete Comment" },

        -- 2. Map phím điều hướng File (Next/Prev File)
        -- Lưu ý: Octo thường dùng Location List cho danh sách file trong review
        next_entry = { lhs = "]f", desc = "Next File" },
        prev_entry = { lhs = "[f", desc = "Prev File" },

        -- Map phím duyệt file (Mark Viewed) + Next file
        toggle_viewed = { lhs = "<leader>mv", desc = "Mark Viewed" },
      },
    },
  },
}
