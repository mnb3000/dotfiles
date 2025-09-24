-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

local helpers = require("config.helpers")

vim.g.snacks_animate = false

vim.o.exrc = true -- execute local .nvim.lua files

-- -- Prepend mise shims to PATH
if vim.fn.executable("mise") == 1 then
  vim.env.PATH = vim.env.PATH .. vim.env.HOME .. "/.local/share/mise/shims"
end

-- Personal Macbook specific config (extra LSPs etc)
if helpers.isPersonalMacbook() then
  vim.lsp.enable("arduino_language_server")

  vim.filetype.add({
    extension = {
      applescript = "applescript",
    },
  })
end
