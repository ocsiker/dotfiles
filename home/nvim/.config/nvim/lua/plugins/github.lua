-- ~/.config/nvim/lua/plugins/github.lua
return {
  -- Octo với fzf-lua
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ibhagwan/fzf-lua",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Octo",
    config = function()
      require("octo").setup({
        picker = "fzf-lua",
      })
    end,
    keys = {
      -- Sử dụng <leader>o (Open/Online) cho GitHub
      { "<leader>oo", "<cmd>Octo<cr>", desc = "Octo menu" },
      { "<leader>oi", "<cmd>Octo issue list<cr>", desc = "Octo issues" },
      { "<leader>op", "<cmd>Octo pr list<cr>", desc = "Octo PRs" },
      { "<leader>or", "<cmd>Octo repo view<cr>", desc = "Octo repo" },
    },
  },

  -- GitLinker
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("gitlinker").setup({
        opts = {
          add_current_line_on_normal_mode = true,
          print_url = false,
        },
        callbacks = {
          ["github.com"] = require("gitlinker.hosts").get_github_type_url,
        },
      })
    end,
    keys = {
      { "<leader>oy", '<cmd>lua require"gitlinker".get_buf_range_url("n")<cr>', desc = "Copy GitHub link" },
      { "<leader>oy", '<cmd>lua require"gitlinker".get_buf_range_url("v")<cr>', mode = "v", desc = "Copy GitHub link" },
      { "<leader>oY", '<cmd>lua require"gitlinker".get_repo_url()<cr>', desc = "Copy repo URL" },
    },
  },

  -- fzf-lua GitHub integrations
  {
    "ibhagwan/fzf-lua",
    keys = {
      -- Browse repo
      {
        "<leader>ob",
        "<cmd>!gh repo view --web<cr>",
        desc = "Browse repo",
      },

      -- Browse issues với preview
      {
        "<leader>oI",
        function()
          require("fzf-lua").fzf_exec("gh issue list", {
            prompt = "Issues❯ ",
            preview = "gh issue view {1}",
            actions = {
              ["default"] = function(selected)
                local issue_number = selected[1]:match("^(%d+)")
                vim.fn.system("gh issue view " .. issue_number .. " --web")
              end,
              ["ctrl-e"] = function(selected)
                local issue_number = selected[1]:match("^(%d+)")
                vim.cmd("edit term://gh issue view " .. issue_number)
              end,
            },
          })
        end,
        desc = "Browse issues",
      },

      -- Browse PRs với preview
      {
        "<leader>oP",
        function()
          require("fzf-lua").fzf_exec("gh pr list", {
            prompt = "PRs❯ ",
            preview = "gh pr view {1}",
            actions = {
              ["default"] = function(selected)
                local pr_number = selected[1]:match("^(%d+)")
                vim.fn.system("gh pr view " .. pr_number .. " --web")
              end,
              ["ctrl-e"] = function(selected)
                local pr_number = selected[1]:match("^(%d+)")
                vim.cmd("edit term://gh pr view " .. pr_number)
              end,
              ["ctrl-d"] = function(selected)
                local pr_number = selected[1]:match("^(%d+)")
                vim.fn.system("gh pr diff " .. pr_number)
              end,
            },
          })
        end,
        desc = "Browse PRs",
      },

      -- Browse repos
      {
        "<leader>oR",
        function()
          require("fzf-lua").fzf_exec("gh repo list --limit 100", {
            prompt = "Repos❯ ",
            actions = {
              ["default"] = function(selected)
                local repo = selected[1]:match("^(%S+)")
                vim.fn.system("gh repo view " .. repo .. " --web")
              end,
            },
          })
        end,
        desc = "Browse repos",
      },

      -- Search code
      {
        "<leader>os",
        function()
          vim.ui.input({ prompt = "Search code: " }, function(input)
            if input then
              require("fzf-lua").fzf_exec("gh search code '" .. input .. "'", {
                prompt = "Code Search❯ ",
              })
            end
          end)
        end,
        desc = "Search GitHub code",
      },

      -- Browse gists
      {
        "<leader>og",
        function()
          require("fzf-lua").fzf_exec("gh gist list", {
            prompt = "Gists❯ ",
            actions = {
              ["default"] = function(selected)
                local gist_id = selected[1]:match("^(%S+)")
                vim.fn.system("gh gist view " .. gist_id .. " --web")
              end,
            },
          })
        end,
        desc = "Browse gists",
      },
    },
  },

  -- Which-key configuration
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.spec = opts.spec or {}
      vim.list_extend(opts.spec, {
        { "<leader>o", group = "open/online" },
      })
    end,
  },
}
