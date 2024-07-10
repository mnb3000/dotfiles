local animate = require("mini.animate")

return {
  "echasnovski/mini.animate",
  opts = {
    scroll = {
      timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
    },
  },
}
