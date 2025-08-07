local helpers = require("config.helpers")
return {
  "mason-org/mason.nvim",
  -- opts = { ensure_installed = { "arduino-language-server" } },
  opts = function(_, opts)
    if helpers.isPersonalMacbook() then
      table.insert(opts, { ensure_installed = "arduino-language-server" })
    end
  end,
}
