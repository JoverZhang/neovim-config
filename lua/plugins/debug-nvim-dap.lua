if true then
  return {}
end

local utils = require("utils")

local debugging_keys = {
  {
    "<leader><F5>",
    function()
      require("dap").terminate()
      require("dapui").close()
    end,
    desc = "terminate nvim-dap debugging",
  },
  {
    "<F5>",
    function()
      require("dap").continue()
      require("dapui").open()
    end,
    desc = "start or continue",
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
      require("dap").run_last()
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
    "<leader>di",
    function()
      require("dapui").eval()
    end,
    desc = "Debug Inspect",
  },
  {
    "<leader>ddr",
    function()
      require("dapui").open({ reset = true })
    end,
    desc = "Reset nvim-dap-ui",
  },
}

local dap_keys = function()
  local running = false
  return {
    {
      "<leader>dds",
      function()
        if running then
          -- stop
          utils.delete_keys(debugging_keys)
          running = false
          print("=== debugger nvim-dap is Stopped ===")
        else
          -- start
          utils.mapping_keys(debugging_keys)
          running = true
          print("=== debugger nvim-dap is Started ===")
        end
      end,

      desc = "Start nvim-dap debugging",
    },
    {
      "<leader>ddu",
      function()
        require("dapui").toggle()
      end,
      desc = "toggle nvim-dap-ui",
    },
    {
      "<leader>ddr",
      function()
        require("dapui").open({ reset = true })
      end,
      desc = "Reset nvim-dap-ui",
    },
  }
end

return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      init = function()
        require("which-key").register({
          ["<leader>dd"] = { name = "nvim-dap" },
        })

        local dap = require("dap")

        -- python
        dap.adapters.python = {
          type = "executable",
          command = "/usr/bin/python",
          args = { "-m", "debugpy.adapter" },
        }
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

        -- c, cpp, rust
        dap.adapters["lldb-vscode"] = {
          type = "executable",
          command = "/usr/bin/lldb-vscode",
        }
        dap.adapters.codelldb = {
          type = "server",
          port = "${port}",
          executable = {
            command = "/usr/bin/codelldb",
            args = { "--port", "${port}" },
          },
        }
        dap.configurations.cpp = {
          -- {
          --   name = "Launch (lldb-vscode)",
          --   type = "lldb-vscode",
          --   request = "launch",
          --   program = function()
          --     return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          --   end,
          --   cwd = "${workspaceFolder}",
          --   stopOnEntry = false,
          --   args = {},
          -- },
          {
            name = "Launch (codelldb)",
            type = "codelldb",
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

        -- go
        dap.adapters.go = {
          type = "executable",
          command = "node",
          args = { os.getenv("HOME") .. "/Workspace/sourcecode/github/vscode-go/dist/debugAdapter.js" },
        }
        dap.configurations.go = {
          {
            type = "go",
            name = "Debug",
            request = "launch",
            showLog = false,
            program = "${file}",
            dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
          },
        }
      end,

      keys = dap_keys,
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
                size = 0.5,
              },
              {
                id = "watches",
                size = 0.2,
              },
              {
                id = "stacks",
                size = 0.2,
              },
              {
                id = "breakpoints",
                size = 0.1,
              },
            },
            position = "left",
            size = 40,
          },
          {
            elements = {
              {
                id = "repl",
                size = 0.7,
              },
              {
                id = "console",
                size = 0.3,
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

  {
    "theHamsta/nvim-dap-virtual-text",
    init = function()
      require("nvim-dap-virtual-text").setup({
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = false, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = false, -- prefix virtual text with comment string
        only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
        all_references = false, -- show virtual text on all all references of the variable (not only definitions)
        --- A callback that determines how a variable is displayed or whether it should be omitted
        --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
        --- @param buf number
        --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
        --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
        --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
        display_callback = function(variable, _buf, _stackframe, _node)
          return variable.name .. " = " .. variable.value
        end,

        -- experimental features:
        virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
        all_frames = true, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      })
    end,
  },
}
