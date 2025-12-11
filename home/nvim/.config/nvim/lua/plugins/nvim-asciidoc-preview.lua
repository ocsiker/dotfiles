return {
  "tigion/nvim-asciidoc-preview",
  ft = { "asciidoc", "asciidoctor" },
  build = "cd server && npm install",
  opts = {
    -- Add user configuration here
  },
  keys = {
    -- map phím bật preview
    { "<leader>op", "<cmd>AsciidocPreview<CR>", desc = "Open Adoc Preview" },
  },
}
