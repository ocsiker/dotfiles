return {
  "tigion/nvim-asciidoc-preview",
  ft = { "asciidoc", "asciidoctor" },
  build = "cd server && npm install",
  opts = {
    -- Add user configuration here
  },
}
