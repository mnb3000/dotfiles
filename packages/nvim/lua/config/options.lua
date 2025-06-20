-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- -- Prepend mise shims to PATH

vim.g.snacks_animate = false

if vim.fn.executable("mise") == 1 then
  vim.env.PATH = vim.env.PATH .. vim.env.HOME .. "/.local/share/mise/shims"
end

vim.filetype.add({
  extension = {
    applescript = "applescript",
  },
})

local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
ft_to_parser.eta = "html"
