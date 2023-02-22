local utils = require("utils")
---core code
local start
local quit

local normalKeys = {
  {
    "<leader>dss",
    function()
      start()
    end,
    desc = "Start vim-spector debugging",
  },
  { "<leader>dsb", "<Plug>VimspectorToggleBreakpoint", desc = "Toggle line breakpoint on the current line" },
  { "<leader>dsf", "<Plug>VimspectorAddFunctionBreakpoint", desc = "Add a function breakpoint" },
}

local debuggingKeys = {
  {
    "<leader><F5>",
    function()
      quit()
    end,
    desc = "Quit vim-spector debugging",
  },
  { "<F5>", "<Plug>VimspectorContinue", desc = "Continue" },
  { "<F17>", "<Plug>VimspectorStop", desc = "<S-F5> Stop debugging" },
  { "<F41>", "<Plug>VimspectorRestart", desc = "<C-S-F5> Restart debugging with the same configuration" },
  { "<F8>", "<Plug>VimspectorJumpToNextBreakpoint", desc = "Jump to next breakpoint" },
  { "<F20>", "<Plug>VimspectorJumpToPreviousBreakpoint", desc = "<S-F8> Jump to previous breakpoint" },
  { "<F9>", "<Plug>VimspectorToggleBreakpoint", desc = "Toggle line breakpoint on the current line" },
  { "<F21>", "<Plug>VimspectorAddFunctionBreakpoint", desc = "<S-F9> Add a function breakpoint" },
  { "<F10>", "<Plug>VimspectorStepOver", desc = "Step Over" },
  { "<F11>", "<Plug>VimspectorStepInto", desc = "Step Info" },
  { "<F23>", "<Plug>VimspectorStepOut", desc = "<S-F11> Step Out" },
  { "<F3>", "<Plug>VimspectorUpFrame", desc = "Stack frame up" },
  { "<F4>", "<Plug>VimspectorDownFrame", desc = "Stack frame down" },
  { "<leader>B", "<Plug>VimspectorBreakpoints", desc = "Show breakpoints" },
  { "<leader>D", "<Plug>VimspectorDisassemble", desc = "Show disassembly" },
  { "<leader>di", "<Plug>VimspectorBalloonEval", desc = "Debug Inspect", mode = { "n", "x" } },
}

start = function()
  vim.cmd("call vimspector#Continue()")
  utils.deleteKeys(normalKeys)
  utils.mappingKeys(debuggingKeys)
end

quit = function()
  vim.cmd("call vimspector#Reset()")
  utils.deleteKeys(debuggingKeys)
  utils.mappingKeys(normalKeys)
end

vim.cmd("let g:vimspector_base_dir='/home/jover/.local/share/nvim/lazy/vimspector'")

return {
  "puremourning/vimspector",
  keys = function()
    return normalKeys
  end,
}
