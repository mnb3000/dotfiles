local do_setcd = function(state)
  local p = state.tree:get_node().path
  print(p) -- show in command line
  vim.cmd(string.format('exec(":lcd %s")', p))
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    commands = {
      setcd = function(state)
        do_setcd(state)
      end,
      grep = function(state)
        do_setcd(state)
        require("telescope.builtin").live_grep()
      end,
    },
    window = {
      mappings = {
        ["/"] = "grep",
        ["g"] = "setcd",
      },
    },
  },
}
