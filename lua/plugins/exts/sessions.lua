local M = {}

function M.load()
  require("persistence").load()
  require("plugins.exts.breakpoints").load_breakpoints()
end

return M
