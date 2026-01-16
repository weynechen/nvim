-- Editor enhancements
return {
  -- File explorer (like VS Code sidebar)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        sources = {
          "filesystem",
          "buffers",
          "git_status",
          "distant", -- Custom distant source
        },
        window = {
          width = 30,
          mappings = {
            ["<space>"] = "none", -- Don't conflict with leader
          },
        },
        filesystem = {
          bind_to_cwd = true,
          cwd_target = {
            sidebar = "window",
            current = "window",
          },
          follow_current_file = { enabled = true },
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          hijack_netrw_behavior = "open_current",
        },
        distant = {
          window = {
            mappings = {
              ["<cr>"] = "open",
              ["o"] = "open",
              ["<2-LeftMouse>"] = "open",
              ["s"] = "open_split",
              ["v"] = "open_vsplit",
              ["R"] = "refresh",
              ["u"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["<bs>"] = "close_node",
              ["q"] = "close_window",
              ["?"] = "show_help",
            },
          },
        },
      })
    end,
  },

  -- Oil (edit filesystem like a buffer)
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        view_options = { show_hidden = true },
        keymaps = {
          ["<C-h>"] = false, -- Don't override window nav
          ["<C-l>"] = false,
        },
      })
    end,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 15,
        -- open_mapping = [[<C-`>]],
        direction = "horizontal",
        shade_terminals = true,
      })
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = true,
  },

  -- Trouble (diagnostics, quickfix in a nice UI)
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    opts = {},
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
    end,
  },

  -- Better markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "markdown" },
    config = function()
      require("render-markdown").setup({
        enabled = true,
        render_modes = { "n", "v", "i", "c" },
        checkbox = {
          enabled = true,
          unchecked = {
            icon = "󰄱 ",
            highlight = "RenderMarkdownUnchecked",
          },
          checked = {
            icon = "󰄵 ",
            highlight = "RenderMarkdownChecked",
          },
        },
        bullet = {
          enabled = true,
          icons = { "•", "◦", "▪", "▫" },
        },
      })
      -- Set highlight colors (catppuccin mocha palette)
      vim.api.nvim_set_hl(0, "RenderMarkdownUnchecked", { fg = "#89b4fa" })  -- blue
      vim.api.nvim_set_hl(0, "RenderMarkdownChecked", { fg = "#a6e3a1" })    -- green
    end,
  },
}
