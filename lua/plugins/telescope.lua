-- Telescope - Fuzzy finder (like Ctrl+P in VS Code)

return {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make", -- windows need to install make
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<Esc>"] = actions.close,
            ["<CR>"] = actions.select_default,
          },
        },
        file_ignore_patterns = { "node_modules", ".git/", ".obsidian/" },
        -- 禁用treesitter预览以避免兼容性问题
        preview = {
          treesitter = false,
        },
      },
      pickers = {
        find_files = {
          -- Only use hidden on non-Windows or when fd is available
          hidden = vim.fn.has("win32") == 0 or vim.fn.executable("fd") == 1,
          find_command = vim.fn.executable("fd") == 1
            and { "fd", "--type", "f", "--hidden", "--exclude", ".git" }
            or nil,
        },
      },
    })
    -- fzf extension: requires compilation (cmake/make/zig)
    -- If not available, Telescope will use built-in Lua matcher (slower but works)
    local ok, err = pcall(telescope.load_extension, "fzf")
    if not ok then
      vim.notify(
        "telescope-fzf-native failed to load. Using built-in matcher.\nInstall 'zig' and run :Lazy build telescope-fzf-native.nvim",
        vim.log.levels.WARN
      )
    end
  end,
}
