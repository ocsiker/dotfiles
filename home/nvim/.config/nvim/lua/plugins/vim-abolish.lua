-- this is for coercion (ép kiểu chuyển từ camel qua snake)
return {
  {
    "tpope/vim-abolish",
    -- Quan trọng: Dòng này báo cho LazyVim biết
    -- "Chỉ khi nào người dùng gõ cụm phím bắt đầu bằng 'cr' thì mới tải plugin này"
    keys = {
      { "cr", desc = "Coerce (Abolish)" },
    },
  },
}
