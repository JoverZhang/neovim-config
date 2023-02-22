local utils = require("utils")
---core code
local start
local quit

local normalKeys = {
  {
    "<leader>dds",
    function()
      start()
    end,
    desc = "Start nvim-dap debugging",
  },
  {
    "<leader>ddb",
    function()
      require("dap").toggle_breakpoint()
    end,
    desc = "toggle_breakpoint",
  },
  {
    "<leader>ddu",
    function()
      require("dapui").toggle()
    end,
    desc = "toggle nvim-dap-ui",
  },
}

local debuggingKeys = {
  {
    "<leader><F5>",
    function()
      quit()
    end,
    desc = "Quit nvim-dap debugging",
  },
  {
    "<F5>",
    function()
      require("dap").continue()
    end,
    desc = "continue",
  },
  {
    "<F17>",
    function()
      require("dap").terminate()
    end,
    desc = "<S-F5> stop",
  },
  {
    "<F41>",
    function()
      require("dap").restart()
    end,
    desc = "<C-S-F5> restart",
  },
  {
    "<F9>",
    function()
      require("dap").toggle_breakpoint()
    end,
    desc = "toggle_breakpoint",
  },
  {
    "<F10>",
    function()
      require("dap").step_over()
    end,
    desc = "step_over",
  },
  {
    "<F11>",
    function()
      require("dap").step_into()
    end,
    desc = "step_into",
  },
  {
    "<F23>",
    function()
      require("dap").step_out()
    end,
    desc = "<S-F11> step_out",
  },
  {
    "<F3>",
    function()
      require("dap").up()
    end,
    desc = "stack up",
  },
  {
    "<F4>",
    function()
      require("dap").down()
    end,
    desc = "stack down",
  },

  -- ui
  {
    "<leader>ddu",
    function()
      require("dapui").toggle()
    end,
    desc = "toggle nvim-dap-ui",
  },
  {
    "<leader>di",
    function()
      require("dapui").eval()
    end,
    desc = "Debug Inspect",
  },
}

start = function()
  require("dap").continue()
  require("dapui").open()
  utils.deleteKeys(normalKeys)
  utils.mappingKeys(debuggingKeys)
end

quit = function()
  require("dap").terminate()
  require("dapui").close()
  utils.deleteKeys(debuggingKeys)
  utils.mappingKeys(normalKeys)
end

return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      init = function()
        local dap = require("dap")

        -- adapters

        -- python
        dap.adapters.python = {
          type = "executable",
          command = "/usr/bin/python",
          args = { "-m", "debugpy.adapter" },
        }
        -- cpp
        dap.adapters["lldb-vscode"] = {
          type = "executable",
          command = "/usr/bin/lldb-vscode",
        }

        -- configurations

        dap.configurations.python = {
          {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            pythonPath = function()
              return "/usr/bin/python"
            end,
          },
        }
        dap.configurations.cpp = {
          {
            name = "Launch",
            type = "lldb-vscode",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
          },
        }
        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp
      end,
      keys = normalKeys,
    },
    config = function()
      require("dapui").setup({
        controls = {
          element = "repl",
          enabled = true,
          icons = {
            disconnect = "",
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = "",
          },
        },
        element_mappings = {},
        expand_lines = true,
        floating = {
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        force_buffers = true,
        icons = {
          collapsed = "",
          current_frame = "",
          expanded = "",
        },
        layouts = {
          {
            elements = {
              {
                id = "scopes",
                size = 0.25,
              },
              {
                id = "breakpoints",
                size = 0.25,
              },
              {
                id = "stacks",
                size = 0.25,
              },
              {
                id = "watches",
                size = 0.25,
              },
            },
            position = "left",
            size = 40,
          },
          {
            elements = {
              {
                id = "repl",
                size = 0.5,
              },
              {
                id = "console",
                size = 0.5,
              },
            },
            position = "bottom",
            size = 10,
          },
        },
        mappings = {
          edit = "e",
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          repl = "r",
          toggle = "t",
        },
        render = {
          indent = 1,
          max_value_lines = 100,
        },
      })
    end,
  },
}
