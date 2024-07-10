local animate = require("mini.animate")

return {
  "echasnovski/mini.animate",
  opts = {
    scroll = {
      timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
    },
  },
  enabled = vim.fn.has("linux") == 0,
  keys = {
    {
      "<C-d>",
      [[<Cmd>lua vim.cmd('normal! <C-d>'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<CR>]],
      mode = { "n" },
    },
    {
      "<C-u>",
      [[<Cmd>lua vim.cmd('normal! <C-u>'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<CR>]],
      mode = { "n" },
    },
    {
      "n",
      [[<Cmd>lua vim.cmd('normal! n'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<CR>]],
      mode = { "n" },
    },
    {
      "N",
      [[<Cmd>lua vim.cmd('normal! N'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<CR>]],
      mode = { "n" },
    },
  },
}
