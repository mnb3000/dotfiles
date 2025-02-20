return {
  "rachartier/tiny-glimmer.nvim",
  event = "VeryLazy",
  opts = {
    overwrite = {
      -- auto_map = false,
      default_animation = {
        name = "fade",

        settings = {
          max_duration = 750,
          min_duration = 750,

          from_color = "DiffDelete",
          to_color = "Normal",
        },
      },

      yank = {
        enabled = true,
        default_animation = "fade",
      },
      paste = {
        enabled = true,
        default_animation = "reverse_fade",
      },
      undo = {
        enabled = true,
      },
      redo = {
        enabled = true,
      },
    },
  },
}
