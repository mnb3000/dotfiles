local do_setcd = function(state)
  local p = state.tree:get_node().path
  print(p) -- show in command line
  vim.fn.chdir(p)
end

local do_grep = function(state)
  local prev_dir = vim.fn.getcwd()
  local grep_dir = state.tree:get_node().path
  require("telescope.builtin").live_grep({ cwd = grep_dir })
  vim.fn.chdir(prev_dir)
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    commands = {
      setcd = function(state)
        do_setcd(state)
      end,
      grep = function(state)
        do_grep(state)
      end,
    },
    window = {
      mappings = {
        ["/"] = "grep",
        ["<c-/>"] = "fuzzy_finder",
        ["g"] = "setcd",
      },
    },
  },
}
