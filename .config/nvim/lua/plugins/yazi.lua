return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "-",
      function()
        require("yazi").yazi()
      end,
      desc = "Open the file manager",
    },
    {
      -- Open in the current working directory
      "<leader>cw",
      function()
        require("yazi").yazi(nil, vim.fn.getcwd())
      end,
      desc = "Open the file manager in nvim's working directory",
    },
  },
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = true,
    enable_mouse_support = true,
    yazi_floating_window_border = "rounded",
    yazi_floating_window_winblend = 5,
    floating_window_scaling_factor = 0.85,
    hooks = {
      yazi_closed_successfully = function(chosen_file, config, state)
        if chosen_file == nil and state.last_directory.filename then
          vim.notify("Changing directory to " .. state.last_directory.filename)
          vim.fn.chdir(state.last_directory.filename)
        end
      end,
    },
  },
}
