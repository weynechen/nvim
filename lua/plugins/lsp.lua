-- LSP Configuration (nvim 0.11+)
return {
  -- Mason: Package manager for LSP servers, formatters, linters
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
          border = "rounded",
        },
      })
    end,
  },

  -- Bridge between mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          -- "gopls",
          "clangd",
          "pyright",
          "jsonls",
          "yamlls",
          "html",
          "cssls",
          "tailwindcss",
          "marksman",
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSP setup using nvim 0.11 native API
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Detect and set .venv for pyright
      local function get_python_path()
        local cwd = vim.fn.getcwd()
        local venv_path = cwd .. "/.venv/bin/python"
        if vim.fn.executable(venv_path) == 1 then
          return venv_path
        end
        return "python"
      end

-- Clangd compile_commands.json management
local ClangdConfig = {
  -- User-specified directory (highest priority, once set, never auto-change)
  custom_compile_commands_dir = nil,
}

-- Find compile_commands.json directory with priority:
-- 1. User-specified (highest)
-- 2. Auto-detect in root/build or root
-- 3. Fallback to cwd
local function get_compile_commands_dir()
  -- Highest priority: user-specified
  if ClangdConfig.custom_compile_commands_dir then
    return ClangdConfig.custom_compile_commands_dir
  end

  -- Auto-detect: check cwd/build and cwd
  local cwd = vim.fn.getcwd()
  local candidates = { cwd .. "/build", cwd }
  for _, dir in ipairs(candidates) do
    if vim.loop.fs_stat(dir .. "/compile_commands.json") then
      return dir
    end
  end

  -- Fallback to cwd/build (common CMake output dir)
  return cwd .. "/build"
end

-- Build clangd command with --compile-commands-dir
local function get_clangd_cmd()
  local compile_dir = get_compile_commands_dir()
  return {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--compile-commands-dir=" .. compile_dir,
  }
end

-- User command to manually set compile_commands.json directory
vim.api.nvim_create_user_command("ClangdCompileCommandDir", function(opts)
  local path = vim.fn.expand(opts.args)
  -- Validate: directory exists or contains compile_commands.json
  if vim.fn.isdirectory(path) == 1 then
    ClangdConfig.custom_compile_commands_dir = path
    vim.notify("Set compile_commands.json dir to: " .. path .. " (locked)", vim.log.levels.INFO)
    -- Restart clangd with new path
    vim.cmd("LspRestart clangd")
  else
    vim.notify("Invalid directory: " .. path, vim.log.levels.ERROR)
  end
end, {
  nargs = 1,
  complete = "dir",
  desc = "Set custom compile_commands.json directory for clangd (highest priority)",
})

-- User command to clear manual setting and use auto-detect
vim.api.nvim_create_user_command("ClangdCompileCommandDirReset", function()
  ClangdConfig.custom_compile_commands_dir = nil
  vim.notify("Reset to auto-detect mode", vim.log.levels.INFO)
  vim.cmd("LspRestart clangd")
end, {
  desc = "Reset clangd compile_commands.json directory to auto-detect",
})

      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          -- Set Python path for pyright
          if client and client.name == "pyright" then
            client.config.settings = client.config.settings or {}
            client.config.settings.python = client.config.settings.python or {}
            client.config.settings.python.pythonPath = get_python_path()
            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
          end

          local bufnr = args.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
          map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "gr", vim.lsp.buf.references, "Go to references")
          map("n", "K", vim.lsp.buf.hover, "Hover documentation")
          map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
          map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>rp", function() vim.cmd("LspRestart pyright") end, "Restart pyright")
          map("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format")
          map("n", "<F2>", vim.lsp.buf.rename, "Rename symbol")
          map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
          map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
        end,
      })

      -- Configure servers using vim.lsp.config (nvim 0.11+)
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim", "Snacks" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
        pyright = {
          settings = {
            python = {
              -- pythonPath is computed at config time, not as a function
              pythonPath = (function()
                local cwd = vim.fn.getcwd()
                -- Windows uses Scripts/python.exe, Unix uses bin/python
                local venv_python = vim.fn.has("win32") == 1
                  and cwd .. "/.venv/Scripts/python.exe"
                  or cwd .. "/.venv/bin/python"
                if vim.fn.executable(venv_python) == 1 then
                  return venv_python
                end
                return vim.fn.exepath("python") or "python"
              end)(),
            },
          },
        },
        jsonls = {},
        yamlls = {},
        html = {},
        cssls = {},
        tailwindcss = {},
        marksman = {},
        clangd = {
          cmd = get_clangd_cmd(),
          -- Use project markers, fallback to cwd (stable root for external files)
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local util = require("lspconfig.util")
            -- Try to find project root by markers
            local root = util.root_pattern(
              ".clangd",
              ".clang-tidy",
              ".clang-format",
              "compile_commands.json",
              "compile_flags.txt",
              "configure.ac",
              ".git",
              "CMakeLists.txt",
              "Makefile"
            )(fname)
            -- Fallback to cwd for external files (e.g., library headers)
            on_dir(root or vim.fn.getcwd())
          end,
        },
        -- gopls = {
        --   settings = {
        --     gopls = {
        --       analyses = { unusedparams = true },
        --       staticcheck = true,
        --       gofumpt = true,
        --     },
        --   },
        -- },
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.config[server] = config
        vim.lsp.enable(server)
      end

      -- Diagnostic signs
      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰌵 ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded" },
      })
    end,
  },

  -- none-ls (null-ls successor) - Formatters/Linters as LSP
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.stylua,
          -- null_ls.builtins.formatting.gofumpt,
          -- null_ls.builtins.formatting.goimports,
          null_ls.builtins.formatting.clang_format,
        },
      })
    end,
  },

  -- Trouble: Pretty diagnostics list
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    },
    opts = { use_diagnostic_signs = true },
  },

  -- Fidget: LSP progress indicator
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = { window = { winblend = 0 } },
    },
  },
}
