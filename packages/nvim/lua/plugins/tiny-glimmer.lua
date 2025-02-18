return {
  "rachartier/tiny-glimmer.nvim",
  event = "VeryLazy",
  opts = {
    overwrite = {
      default_animation = {
        name = "fade",

        settings = {
          max_duration = 500,
          min_duration = 500,

          from_color = "DiffDelete",
          to_color = "Normal",
        },
      },

      yank = {
        enabled = true,
        default_animation = "fade",
      },
      search = {
        enabled = true,
        default_animation = "pulse",

        -- Keys to navigate to the next match
        next_mapping = "nzzzv",

        -- Keys to navigate to the previous match
        prev_mapping = "Nzzzv",
      },
      paste = {
        enabled = true,
        default_animation = "reverse_fade",

        -- Keys to paste
        paste_mapping = "p",

        -- Keys to paste above the cursor
        Paste_mapping = "P",
      },
      undo = {
        enabled = true,

        default_animation = {
          name = "fade",

          settings = {
            from_color = "DiffDelete",

            max_duration = 500,
            min_duration = 500,
          },
        },
        undo_mapping = "u",
      },
      redo = {
        enabled = false,

        default_animation = {
          name = "fade",

          settings = {
            from_color = "DiffAdd",

            max_duration = 500,
            min_duration = 500,
          },
        },

        redo_mapping = "<c-r>",
      },
    },
  },
}
