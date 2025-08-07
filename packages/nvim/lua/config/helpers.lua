local M = {}

function M.isPersonalMacbook()
  local hostname = vim.uv.os_gethostname()
  return hostname:find("myk-personal", 1, true)
end

return M
