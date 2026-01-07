-- Obsidian.nvim - Vault integration

-- Only load if vault directory exists
local vault_path = vim.fn.expand("~/vault")
local vault_exists = vim.fn.isdirectory(vault_path) == 1

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  cond = vault_exists, -- Disable plugin if vault doesn't exist
  ft = "markdown",
  event = vault_exists and {
    "BufReadPre " .. vault_path .. "/**.md",
    "BufNewFile " .. vault_path .. "/**.md",
  } or {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "vault",
        path = "~/vault",
      },
    },
    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
      template = "templates/daily.md",
    },
    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    new_notes_location = "current_dir",
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        suffix = tostring(os.time())
      end
      return suffix
    end,
    -- Disable UI features (we use render-markdown instead)
    ui = { enable = false },
    -- Disable legacy commands
    legacy_commands = false,
  },
}
