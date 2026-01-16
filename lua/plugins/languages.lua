-- Language-specific plugins
return {
  -- Rust: rustaceanvim (the best Rust plugin)
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          hover_actions = { auto_focus = true },
        },
        server = {
          on_attach = function(client, bufnr)
            local map = function(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end
            -- Rust-specific keymaps
            map("n", "<leader>rd", "<cmd>RustLsp debuggables<CR>", "Rust debuggables")
            map("n", "<leader>rr", "<cmd>RustLsp runnables<CR>", "Rust runnables")
            map("n", "<leader>rt", "<cmd>RustLsp testables<CR>", "Rust testables")
            map("n", "<leader>re", "<cmd>RustLsp expandMacro<CR>", "Expand macro")
            map("n", "<leader>rc", "<cmd>RustLsp openCargo<CR>", "Open Cargo.toml")
            map("n", "<leader>rp", "<cmd>RustLsp parentModule<CR>", "Parent module")
            map("n", "<leader>rj", "<cmd>RustLsp joinLines<CR>", "Join lines")
            map("n", "<leader>rh", "<cmd>RustLsp hover actions<CR>", "Hover actions")
            map("n", "J", "<cmd>RustLsp joinLines<CR>", "Join lines (Rust)")
          end,
          default_settings = {
            ["rust-analyzer"] = {
              checkOnSave = { command = "clippy" },
              cargo = { allFeatures = true },
              procMacro = { enable = true },
            },
          },
        },
      }
    end,
  },

  -- Crates.nvim: Cargo.toml dependency management
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local crates = require("crates")
      crates.setup({
        popup = { border = "rounded" },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      })

      -- Keymaps for Cargo.toml
      vim.api.nvim_create_autocmd("BufRead", {
        pattern = "Cargo.toml",
        callback = function()
          local map = vim.keymap.set
          map("n", "<leader>ct", crates.toggle, { buffer = true, desc = "Toggle crates" })
          map("n", "<leader>cr", crates.reload, { buffer = true, desc = "Reload crates" })
          map("n", "<leader>cv", crates.show_versions_popup, { buffer = true, desc = "Show versions" })
          map("n", "<leader>cf", crates.show_features_popup, { buffer = true, desc = "Show features" })
          map("n", "<leader>cd", crates.show_dependencies_popup, { buffer = true, desc = "Show deps" })
          map("n", "<leader>cu", crates.update_crate, { buffer = true, desc = "Update crate" })
          map("n", "<leader>cU", crates.upgrade_crate, { buffer = true, desc = "Upgrade crate" })
          map("n", "<leader>cA", crates.upgrade_all_crates, { buffer = true, desc = "Upgrade all" })
        end,
      })
    end,
  },

  -- Go
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup({
        lsp_cfg = false, -- We handle LSP in lsp.lua
        lsp_keymaps = false,
        dap_debug = true,
      })

      -- Go keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          local map = vim.keymap.set
          map("n", "<leader>gr", "<cmd>GoRun<CR>", { buffer = true, desc = "Go run" })
          map("n", "<leader>gt", "<cmd>GoTest<CR>", { buffer = true, desc = "Go test" })
          map("n", "<leader>gtf", "<cmd>GoTestFunc<CR>", { buffer = true, desc = "Go test func" })
          map("n", "<leader>gc", "<cmd>GoCoverage<CR>", { buffer = true, desc = "Go coverage" })
          map("n", "<leader>gi", "<cmd>GoImports<CR>", { buffer = true, desc = "Go imports" })
          map("n", "<leader>ge", "<cmd>GoIfErr<CR>", { buffer = true, desc = "Go if err" })
          map("n", "<leader>gs", "<cmd>GoFillStruct<CR>", { buffer = true, desc = "Fill struct" })
          map("n", "<leader>ga", "<cmd>GoAddTag<CR>", { buffer = true, desc = "Add tags" })
        end,
      })
    end,
  },

  -- TypeScript (typescript-tools is faster than tsserver)
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      require("typescript-tools").setup({
        settings = {
          separate_diagnostic_server = true,
          publish_diagnostic_on = "insert_leave",
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
      })

      -- TypeScript keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        callback = function()
          local map = vim.keymap.set
          map("n", "<leader>jo", "<cmd>TSToolsOrganizeImports<CR>", { buffer = true, desc = "Organize imports" })
          map("n", "<leader>js", "<cmd>TSToolsSortImports<CR>", { buffer = true, desc = "Sort imports" })
          map("n", "<leader>jr", "<cmd>TSToolsRemoveUnusedImports<CR>", { buffer = true, desc = "Remove unused" })
          map("n", "<leader>jf", "<cmd>TSToolsFixAll<CR>", { buffer = true, desc = "Fix all" })
          map("n", "<leader>ja", "<cmd>TSToolsAddMissingImports<CR>", { buffer = true, desc = "Add missing" })
          map("n", "<leader>jd", "<cmd>TSToolsGoToSourceDefinition<CR>", { buffer = true, desc = "Source def" })
          map("n", "<leader>jR", "<cmd>TSToolsRenameFile<CR>", { buffer = true, desc = "Rename file" })
        end,
      })
    end,
  },

  -- C/C++ extras (clangd-extensions)
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp", "cuda" },
    config = function()
      require("clangd_extensions").setup({
        inlay_hints = {
          inline = vim.fn.has("nvim-0.10") == 1,
          only_current_line = false,
          show_parameter_hints = true,
          parameter_hints_prefix = "<- ",
          other_hints_prefix = "=> ",
        },
        ast = {
          role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
          },
        },
      })

      -- C/C++ keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp" },
        callback = function()
          local map = vim.keymap.set
          map("n", "<leader>lh", "<cmd>ClangdSwitchSourceHeader<CR>", { buffer = true, desc = "Switch header/source" })
          map("n", "<leader>lt", "<cmd>ClangdTypeHierarchy<CR>", { buffer = true, desc = "Type hierarchy" })
          map("n", "<leader>lm", "<cmd>ClangdMemoryUsage<CR>", { buffer = true, desc = "Memory usage" })
          map("n", "<leader>la", "<cmd>ClangdAST<CR>", { buffer = true, desc = "Show AST" })
        end,
      })
    end,
  },

  -- CMake
  {
    "Civitasv/cmake-tools.nvim",
    ft = { "cmake", "c", "cpp" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("cmake-tools").setup({
        cmake_command = "cmake", -- this is used to specify cmake command path
        ctest_command = "ctest", -- this is used to specify ctest command path
        cmake_use_preset = true,
        cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
        cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
        -- support macro expansion:
        --       ${kit}
        --       ${kitGenerator}
        --       ${variant:xx}
        cmake_build_directory = "build",
        -- cmake_build_directory = function()
        --   if osys.iswin32 then
        --     return "out\\${variant:buildType}"
        --   end
        --   return "out/${variant:buildType}"
        -- end, -- this is used to specify generate directory for cmake, allows macro expansion, can be a string or a function returning the string, relative to cwd.
        cmake_compile_commands_options = {
          action = "lsp", -- available options: soft_link, copy, lsp, none
                                -- soft_link: this will automatically make a soft link from compile commands file to target
                                -- copy:      this will automatically copy compile commands file to target
                                -- lsp:       this will automatically set compile commands file location using lsp
                                -- none:      this will make this option ignored
          -- target = vim.loop.cwd() -- path to directory, this is used only if action == "soft_link" or action == "copy"
        },
        cmake_kits_path = nil, -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
        cmake_variants_message = {
          short = { show = true }, -- whether to show short message
          long = { show = true, max_length = 40 }, -- whether to show long message
        },
        cmake_dap_configuration = { -- debug settings for cmake
          name = "cpp",
          type = "codelldb",
          request = "launch",
          stopOnEntry = false,
          runInTerminal = true,
          console = "integratedTerminal",
        },
        cmake_executor = { -- executor to use
          name = "quickfix", -- name of the executor
          opts = {}, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
          default_opts = { -- a list of default and possible values for executors
            quickfix = {
              show = "always", -- "always", "only_on_error"
              position = "belowright", -- "vertical", "horizontal", "leftabove", "aboveleft", "rightbelow", "belowright", "topleft", "botright", use `:h vertical` for example to see help on them
              size = 10,
              encoding = "utf-8", -- if encoding is not "utf-8", it will be converted to "utf-8" using `vim.fn.iconv`
              auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
            },
            toggleterm = {
              direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
              close_on_exit = false, -- whether close the terminal when exit
              auto_scroll = true, -- whether auto scroll to the bottom
              singleton = true, -- single instance, autocloses the opened one, if present
            },
            overseer = {
              new_task_opts = {
                  strategy = {
                      "toggleterm",
                      direction = "horizontal",
                      auto_scroll = true,
                      quit_on_exit = "success"
                  }
              }, -- options to pass into the `overseer.new_task` command
              on_new_task = function(task)
                  require("overseer").open(
                      { enter = false, direction = "right" }
                  )
              end,   -- a function that gets overseer.Task when it is created, before calling `task:start`
            },
            terminal = {
              name = "Main Terminal",
              prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
              split_direction = "horizontal", -- "horizontal", "vertical"
              split_size = 11,
      
              -- Window handling
              single_terminal_per_instance = true, -- Single viewport, multiple windows
              single_terminal_per_tab = true, -- Single viewport per tab
              keep_terminal_static_location = true, -- Static location of the viewport if avialable
              auto_resize = true, -- Resize the terminal if it already exists
      
              -- Running Tasks
              start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
              focus = false, -- Focus on terminal when cmake task is launched.
              do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
            }, -- terminal executor uses the values in cmake_terminal
          },
        },
        cmake_runner = { -- runner to use
          name = "terminal", -- name of the runner
          opts = {}, -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
          default_opts = { -- a list of default and possible values for runners
            quickfix = {
              show = "always", -- "always", "only_on_error"
              position = "belowright", -- "bottom", "top"
              size = 10,
              encoding = "utf-8",
              auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
            },
            toggleterm = {
              direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
              close_on_exit = false, -- whether close the terminal when exit
              auto_scroll = true, -- whether auto scroll to the bottom
              singleton = true, -- single instance, autocloses the opened one, if present
            },
            overseer = {
              new_task_opts = {
                  strategy = {
                      "toggleterm",
                      direction = "horizontal",
                      autos_croll = true,
                      quit_on_exit = "success"
                  }
              }, -- options to pass into the `overseer.new_task` command
              on_new_task = function(task)
              end,   -- a function that gets overseer.Task when it is created, before calling `task:start`
            },
            terminal = {
              name = "Main Terminal",
              prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
              split_direction = "horizontal", -- "horizontal", "vertical"
              split_size = 11,
      
              -- Window handling
              single_terminal_per_instance = true, -- Single viewport, multiple windows
              single_terminal_per_tab = true, -- Single viewport per tab
              keep_terminal_static_location = true, -- Static location of the viewport if avialable
              auto_resize = true, -- Resize the terminal if it already exists
      
              -- Running Tasks
              start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
              focus = false, -- Focus on terminal when cmake task is launched.
              do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
            },
          },
        },
        cmake_notifications = {
          runner = { enabled = true },
          executor = { enabled = true },
          spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
          refresh_rate_ms = 100, -- how often to iterate icons
        },
        cmake_virtual_text_support = true, -- Show the target related to current file using virtual text (at right corner)
        cmake_use_scratch_buffer = false, -- A buffer that shows what cmake-tools has done
      }
    )

      -- CMake keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp", "cmake" },
        callback = function()
          local map = vim.keymap.set
          map("n", "<leader>cg", "<cmd>CMakeGenerate<CR>", { buffer = true, desc = "CMake generate" })
          map("n", "<leader>cb", "<cmd>CMakeBuild<CR>", { buffer = true, desc = "CMake build" })
          map("n", "<leader>cr", "<cmd>CMakeRun<CR>", { buffer = true, desc = "CMake run" })
          map("n", "<leader>cd", "<cmd>CMakeDebug<CR>", { buffer = true, desc = "CMake debug" })
          map("n", "<leader>cy", "<cmd>CMakeSelectBuildType<CR>", { buffer = true, desc = "Select build type" })
          map("n", "<leader>ct", "<cmd>CMakeSelectBuildTarget<CR>", { buffer = true, desc = "Select target" })
          map("n", "<leader>cl", "<cmd>CMakeSelectLaunchTarget<CR>", { buffer = true, desc = "Select launch target" })
          map("n", "<leader>co", "<cmd>CMakeOpen<CR>", { buffer = true, desc = "Open CMake console" })
          map("n", "<leader>cc", "<cmd>CMakeClose<CR>", { buffer = true, desc = "Close CMake console" })
        end,
      })
    end,
  },
}
