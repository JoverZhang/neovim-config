-- persistent for nvim-dap breakpoints
--
-- see https://github.com/mfussenegger/nvim-dap/issues/198

local breakpoints = require("dap.breakpoints")
local BREAKPOINTS_FILE = os.getenv("HOME") .. "/.local/state/nvim/breakpoints.json"

local M = {}

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = vim.api.nvim_create_augroup("nvim-dap-breakpoints", { clear = true }),
  callback = function()
    M.store_breakpoints()
  end,
})

function M.store_breakpoints(clear)
  local fp = io.open(BREAKPOINTS_FILE, "r")
  local bps
  if fp ~= nil then
    local load_bps_raw = fp:read("*a")
    bps = vim.fn.json_decode(load_bps_raw)
  else
    bps = {}
  end

  local breakpoints_by_buf = breakpoints.get()
  if clear then
    for _, bufrn in ipairs(vim.api.nvim_list_bufs()) do
      local file_path = vim.api.nvim_buf_get_name(bufrn)
      if bps[file_path] ~= nil then
        bps[file_path] = {}
      end
    end
  else
    for buf, buf_bps in pairs(breakpoints_by_buf) do
      bps[vim.api.nvim_buf_get_name(buf)] = buf_bps
    end
  end
  local fp = io.open(BREAKPOINTS_FILE, "w")
  local final = vim.fn.json_encode(bps)
  fp:write(final)
  fp:close()
end

function M.load_breakpoints()
  local fp = io.open(BREAKPOINTS_FILE, "r")
  if fp == nil then
    return
  end
  local content = fp:read("*a")
  local bps = vim.fn.json_decode(content)
  local loaded_buffers = {}
  local found = false
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local file_name = vim.api.nvim_buf_get_name(buf)
    if bps[file_name] ~= nil and bps[file_name] ~= {} then
      found = true
    end
    loaded_buffers[file_name] = buf
  end
  if found == false then
    return
  end
  for path, buf_bps in pairs(bps) do
    for _, bp in pairs(buf_bps) do
      local line = bp.line
      local opts = {
        condition = bp.condition,
        log_message = bp.logMessage,
        hit_condition = bp.hitCondition,
      }
      breakpoints.set(opts, tonumber(loaded_buffers[path]), line)
    end
  end
end

return M
