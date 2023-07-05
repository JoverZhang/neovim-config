local M = {}

local persistence = require("persistence")

function M.load()
  persistence.load()
  require("plugins.exts.breakpoints").load_breakpoints()
end

function M.load_recent()
  local sessions = persistence.list()
  table.sort(sessions, function(a, b)
    return vim.loop.fs_stat(a).mtime.sec > vim.loop.fs_stat(b).mtime.sec
  end)

  local items = {}
  for i, session in ipairs(sessions) do
    items[i] = i .. " " .. string.match(session, "^.+/(.+)$")
  end

  vim.ui.select(items, {
    prompt = "Recent Sessions",
  }, function(selected)
    if not selected then
      return
    end
    local index = tonumber(string.match(selected, "^(%d+)"))
    local session = sessions[index]

    -- switch session
    persistence.save()
    vim.cmd("silent! source " .. vim.fn.fnameescape(session))

    vim.notify("cwd change to: " .. vim.fn.getcwd())
  end)
end

return M
