-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- vim.keymap.set("n", "<C-d>", "<C-d>zvzz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zvzz")

vim.keymap.set("n", "n", "nzvzz")
vim.keymap.set("n", "N", "Nzvzz")
vim.keymap.del("n", "<leader>-")
vim.keymap.set("n", "<leader>\\", "<C-W>s", { desc = "Split Window Below", remap = true })
