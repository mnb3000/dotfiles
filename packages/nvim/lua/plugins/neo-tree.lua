local do_setcd = function(state)
  local p = state.tree:get_node().path
  print(p) -- show in command line
  vim.fn.chdir(p)
end

local do_grep = function(state)
  local prev_dir = vim.fn.getcwd()
  local grep_dir = state.tree:get_node().path
  require("fzf-lua").live_grep({ cwd = grep_dir })
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
      width = 32,
      mappings = {
        ["/"] = "grep",
        -- ["<c-/>"] = "fuzzy_finder",
        ["g"] = "setcd",
        ["<space>"] = "none",
      },
    },
    filesystem = {
      hijack_netrw_behavior = "disabled",
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,

      filtered_items = {
        visible = true,
        hide_dotfiles = true,
        hide_gitignored = true,
        -- hide_hidden = true, -- only works on Windows for hidden files/directories
        hide_by_name = {
          ".DS_Store",
          "thumbs.db",
          "node_modules",
          ".git",
        },
        hide_by_pattern = {
          --"*.meta",
        },
        always_show = { -- remains visible even if other settings would normally hide it
          ".gitignore",
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          ".DS_Store",
          "thumbs.db",
        },
      },
    },
  },
}
