-- dành cho file adoc asciidoc
vim.keymap.set("n", "<leader>tc", function()
  local line = vim.api.nvim_get_current_line()
  if line:match("%[ %]") then
    line = line:gsub("%[ %]", "[x]", 1)
  elseif line:match("%[x%]") then
    line = line:gsub("%[x%]", "[ ]", 1)
  end
  vim.api.nvim_set_current_line(line)
end, { desc = "Toggle checkbox (Normal Mode)" })

-- tao file html
vim.keymap.set("n", "<leader>ah", function()
  local file = vim.fn.expand("%:p") -- Lấy đường dẫn đầy đủ của file hiện tại
  local current_dir = vim.fn.expand("%:p:h") -- Lấy thư mục chứa file
  local css_file = current_dir .. "/style.css" -- Định nghĩa file CSS

  -- Khởi tạo lệnh biên dịch
  local cmd = "asciidoctor"

  -- Nếu file style.css tồn tại, thêm vào lệnh
  if vim.fn.filereadable(css_file) == 1 then
    cmd = cmd .. " -a stylesheet=" .. css_file
  end

  cmd = cmd .. " " .. vim.fn.shellescape(file) -- Tránh lỗi ký tự đặc biệt

  -- Chạy lệnh trong terminal
  vim.cmd("!" .. cmd)
end, { desc = "Compile AsciiDoc to HTML" })

-- mo fil html
vim.keymap.set("n", "<leader>aH", function()
  local file = vim.fn.expand("%:p") -- Lấy đường dẫn đầy đủ của file hiện tại
  local output_file = file:gsub("%.adoc$", ".html") -- Đổi đuôi file từ .adoc thành .html

  if vim.fn.filereadable(output_file) == 1 then
    local open_cmd
    if vim.fn.has("mac") == 1 then
      open_cmd = "open " .. vim.fn.shellescape(output_file) -- macOS
    elseif vim.fn.has("unix") == 1 then
      open_cmd = "xdg-open " .. vim.fn.shellescape(output_file) -- Linux
    elseif vim.fn.has("win32") == 1 then
      open_cmd = "start " .. vim.fn.shellescape(output_file) -- Windows
    end

    if open_cmd then
      vim.cmd("!" .. open_cmd)
    else
      print("Không tìm thấy lệnh mở file phù hợp.")
    end
  else
    print("Lỗi: File HTML chưa được tạo! Hãy biên dịch bằng `<leader>ah` trước.")
  end
end, { desc = "Open compiled HTML file" })
