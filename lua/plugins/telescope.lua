-- Telescope - Fuzzy finder (like Ctrl+P in VS Code)

-- Cross-platform build command for fzf-native
local function fzf_native_build()
  if vim.fn.has("win32") == 1 then
    -- Windows: use cmake, then copy DLL to expected location
    return "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && copy build\\Release\\libfzf.dll build\\"
  else
    -- Linux/macOS: use make
    return "make"
  end
end

return {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = fzf_native_build(),
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
        find_files = { hidden = true },
      },
    })
    telescope.load_extension("fzf")
  end,
}
