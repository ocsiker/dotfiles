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
  },

  -- GitLinker
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = {
      { "<leader>gy", mode = { "n", "v" }, desc = "Copy git link" },
    },
  },

  -- fzf-lua GitHub integrations
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>ghb", "<cmd>!gh repo view --web<cr>", desc = "Browse repo" },
      {
        "<leader>ghi",
        function()
          require("fzf-lua").fzf_exec("gh issue list", {
            prompt = "Issues> ",
            preview = "gh issue view {1}",
            actions = {
              ["default"] = function(s)
                vim.fn.system("gh issue view " .. s[1]:match("^(%d+)") .. " --web")
              end,
            },
          })
        end,
        desc = "Issues",
      },
      {
        "<leader>ghp",
        function()
          require("fzf-lua").fzf_exec("gh pr list", {
            prompt = "PRs> ",
            preview = "gh pr view {1}",
            actions = {
              ["default"] = function(s)
                vim.fn.system("gh pr view " .. s[1]:match("^(%d+)") .. " --web")
              end,
            },
          })
        end,
        desc = "PRs",
      },
    },
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>gh", group = "github" },
      },
    },
  },
}
