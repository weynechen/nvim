-- AI Integration
return {
  -- Opencode: AI assistant integration
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    keys = {
      { "<leader>aa", function() require("opencode").ask("@this: ", { submit = true }) end, mode = { "n", "x" }, desc = "Ask opencode" },
      { "<leader>as", function() require("opencode").select() end, mode = { "n", "x" }, desc = "Opencode select action" },
      { "<leader>at", function() require("opencode").toggle() end, mode = { "n", "t" }, desc = "Toggle opencode terminal" },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        provider = {
          enabled = "snacks",
          tmux = {
            -- ...
          }
        }
      }

      -- Required for auto-reload
      vim.o.autoread = true
    end,
  },
}
