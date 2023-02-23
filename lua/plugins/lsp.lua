return {
  -- mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "cmakelang",
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
        require("rust-tools").setup({
          tools = {
            runnables = {
              use_telescope = true,
            },
            inlay_hints = {
              auto = true,
              show_parameter_hints = false,
              parameter_hints_prefix = "",
              other_hints_prefix = "",
            },
          },

          -- all the opts to send to nvim-lspconfig
          -- these override the defaults set by rust-tools.nvim
          -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
          server = {
            -- on_attach is a callback called when the language server attachs to the buffer
            on_attach = function(client, buffer)
              -- This callback is called when the LSP is atttached/enabled for this buffer
              -- we could set keymaps related to LSP, etc here.
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
}
