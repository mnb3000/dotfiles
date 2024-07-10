-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

vim.keymap.set(
  "n",
  "<C-d>",
  [[<Cmd>lua vim.cmd('normal! <C-d>'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<CR>]]
)
vim.keymap.set(
  "n",
  "<C-u>",
  [[<Cmd>lua vim.cmd('normal! <C-u>'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<CR>]]
)

vim.keymap.set("n", "n", [[<Cmd>lua vim.cmd('normal! n'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<CR>]])
vim.keymap.set("n", "N", [[<Cmd>lua vim.cmd('normal! N'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<CR>]])
vim.keymap.del("n", "<leader>-")
vim.keymap.set("n", "<leader>\\", "<C-W>s", { desc = "Split Window Below", remap = true })
