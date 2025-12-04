local M = {}

function M.search_adoc_keywords()
  -- Tìm tất cả file .adoc trong thư mục hiện tại
  local adoc_files = vim.fn.glob("**/*.adoc", true, true)
  local keywords = {}
  local file_paths = {}
  local line_numbers = {}

  -- Quét từng file .adoc
  for _, file in ipairs(adoc_files) do
    local lines = vim.fn.readfile(file)
    for i, line in ipairs(lines) do
      local keyword = line:match("^=== `(.*)`$")
      if keyword then
        -- Lưu từ khóa, đường dẫn file và số dòng
        table.insert(keywords, string.format("%s (%s)", keyword, file))
        table.insert(file_paths, file)
        table.insert(line_numbers, i)
      end
    end
  end

  -- Kiểm tra nếu không tìm thấy từ khóa
  if #keywords == 0 then
    vim.notify("No keywords found in any AsciiDoc files", vim.log.levels.WARN)
    return
  end

  -- Sử dụng fzf-lua để hiển thị danh sách từ khóa
  require("fzf-lua").fzf_exec(keywords, {
    actions = {
      ["default"] = function(selected)
        local idx = 1
        for i, keyword in ipairs(keywords) do
          if keyword == selected[1] then
            idx = i
            break
          end
        end
        -- Mở file và nhảy đến dòng tương ứng
        vim.cmd("edit " .. vim.fn.fnameescape(file_paths[idx]))
        vim.api.nvim_win_set_cursor(0, { line_numbers[idx], 0 })
      end,
    },
    prompt = "Search AsciiDoc Keywords> ",
    winopts = {
      width = 0.8,
      height = 0.6,
    },
  })
end

return M
