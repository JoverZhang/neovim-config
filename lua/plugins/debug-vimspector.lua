local utils = require("utils")

local debugging_keys = {
  { "<leader><F5>", "<cmd>VimspectorReset<cr>", desc = "Quit vim-spector debugging" },
  { "<F5>", "<Plug>VimspectorContinue", desc = "Start or Continue" },
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

vim.cmd("let g:vimspector_base_dir='/home/jover/.local/share/nvim/lazy/vimspector'")

return {
  "puremourning/vimspector",
  init = function()
    require("which-key").register({
      ["<leader>ds"] = { name = "vimspector" },
    })
  end,
  keys = function()
    local running = false
    return {
      {
        "<leader>dss",
        function()
          if running then
            -- stop
            utils.delete_keys(debugging_keys)
            running = false
            print("=== debugger vim-spector is Stopped ===")
          else
            -- start
            utils.mapping_keys(debugging_keys)
            running = true
            print("=== debugger vim-spector is Started ===")
          end
        end,
        desc = "Start or Stop vim-spector debugging",
      },
    }
  end,
}
