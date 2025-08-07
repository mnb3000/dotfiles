local helpers = require("config.helpers")
return {
  "anurag3301/nvim-platformio.lua",

  enabled = function()
    return helpers.isPersonalMacbook()
  end,

  dependencies = {
    { "akinsho/nvim-toggleterm.lua" },
    -- { "nvim-telescope/telescope.nvim" },
    -- { "nvim-telescope/telescope-ui-select.nvim" },
    -- { "nvim-lua/plenary.nvim" },
    -- {
    --   "folke/which-key.nvim",
    --   opts = {
    --     preset = "helix", --'modern', --"classic", --
    --     sort = { "order", "group", "manual", "mod" },
    --   },
    -- },
  },
  opts = {
    lsp = "ccls",
  },
}
