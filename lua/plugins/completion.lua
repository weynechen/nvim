-- Completion with nvim-cmp + lspkind icons
return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      -- Load snippets from friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Configure LuaSnip behavior
      luasnip.config.set_config({
        history = true,              -- Keep last snippet for jumping back
        updateevents = "TextChanged,TextChangedI", -- Update snippets as you type
        enable_autosnippets = true,
        ext_opts = {
          [require("luasnip.util.types").choiceNode] = {
            active = {
              virt_text = { { "●", "GruvboxOrange" } },
            },
          },
        },
      })

      -- Prevent C files from loading C++ snippets
      luasnip.filetype_extend("c", {})  -- C only loads 'c' snippets, not 'cpp'
      -- If you want C++ to also have C snippets, keep the default behavior
      -- luasnip.filetype_extend("cpp", { "c" })  -- C++ can use both cpp and c snippets

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            -- Priority 1: If in snippet, jump to next placeholder
            if luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            -- Priority 2: If completion menu visible, select next item
            elseif cmp.visible() then
              cmp.select_next_item()
            -- Priority 3: If snippet can be expanded, expand it
            elseif luasnip.expandable() then
              luasnip.expand()
            -- Priority 4: Insert tab/spaces
            else
              local keys = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
              vim.api.nvim_feedkeys(keys, "n", false)
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            -- Priority 1: If in snippet, jump to previous placeholder
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            -- Priority 2: If completion menu visible, select previous item
            elseif cmp.visible() then
              cmp.select_prev_item()
            -- Priority 3: Decrease indentation
            else
              local keys = vim.api.nvim_replace_termcodes("<C-d>", true, false, true)
              vim.api.nvim_feedkeys(keys, "n", false)
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },  -- LSP highest priority
          { name = "luasnip", priority = 750 },    -- Snippets second
          { name = "buffer", priority = 500 },     -- Buffer text third
          { name = "path", priority = 250 },       -- Path completion last
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            show_labelDetails = true,
            symbol_map = {
              Copilot = "",
            },
          }),
        },
      })

      -- Cmdline completions
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        }),
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      -- Optional: Completely disable snippets for C files (uncomment if needed)
      -- vim.api.nvim_create_autocmd("FileType", {
      --   pattern = "c",
      --   callback = function()
      --     cmp.setup.buffer({
      --       sources = cmp.config.sources({
      --         { name = "nvim_lsp" },
      --         { name = "buffer" },
      --         { name = "path" },
      --       }),
      --     })
      --   end,
      -- })
    end,
  },

  -- LSPKind: VSCode-like icons in completion menu
  {
    "onsails/lspkind.nvim",
    lazy = true,
  },
}
