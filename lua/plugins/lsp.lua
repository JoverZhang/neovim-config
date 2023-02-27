return {
  -- mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "cmakelang",
        "golangci-lint",
        "goimports",
        "gopls",
        "rust-analyzer",
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    keys = {
      { "ga", vim.lsp.buf.code_action, desc = "lsp code action" },
      { "<leader>cw", vim.lsp.buf.document_symbol, desc = "list all symbols in the current buffer" },
      { "<leader>cW", vim.lsp.buf.workspace_symbol, desc = "list all symbols in the current workspace" },
      { "<leader>c[", vim.diagnostic.goto_prev, desc = "goto prev diagnostic" },
      { "<leader>c]", vim.diagnostic.goto_next, desc = "goto next diagnostic" },
    },
  },

  -- pyright
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  -- rust
  -- see https://sharksforarms.dev/posts/neovim-rust/
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "simrat39/rust-tools.nvim",
      init = function()
        local rt = require("rust-tools")
        rt.setup({
          tools = {
            runnables = {
              use_telescope = true,
            },
            inlay_hints = {
              auto = true,
              show_parameter_hints = true,
              parameter_hints_prefix = "",
              other_hints_prefix = "",
            },
          },

          -- all the opts to send to nvim-lspconfig
          -- these override the defaults set by rust-tools.nvim
          -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
          server = {
            -- on_attach is a callback called when the language server attachs to the buffer
            on_attach = function(_, buffer)
              -- Hover actions
              vim.keymap.set(
                "n",
                "<LocalLeader>ch",
                rt.hover_actions.hover_actions,
                { desc = "hover actions (rust)", buffer = buffer }
              )
              -- Code action groups
              vim.keymap.set(
                "n",
                "<LocalLeader>ca",
                rt.code_action_group.code_action_group,
                { desc = "code action group (rust)", buffer = buffer }
              )
            end,

            settings = {
              -- to enable rust-analyzer settings visit:
              -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
              ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                  command = "clippy",
                },
              },
            },
          },
        })
      end,
    },
  },

  -- golang
  {

    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        goimport = "gopls", -- if set to 'gopls' will use golsp format
        gofmt = "gopls", -- if set to gopls will use golsp format
        max_line_len = 120,
        tag_transform = false,
        test_dir = "",
        comment_placeholder = "   ",
        lsp_cfg = true, -- false: use your own lspconfig
        lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
        lsp_on_attach = true, -- use on_attach from go.nvim
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
