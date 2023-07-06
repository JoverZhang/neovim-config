-- vim.lsp.set_log_level("debug")
return {
  -- mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "cpplint",
        "cmakelang",
        "golangci-lint",
        "goimports",
        "gopls",
        "rust-analyzer",
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "yapf",
      },
    },
  },
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = true,
    },
    keys = {
      { "ga", vim.lsp.buf.code_action, desc = "lsp code action" },
      { "<leader>cw", vim.lsp.buf.document_symbol, desc = "list all symbols in the current buffer" },
      { "<leader>cW", vim.lsp.buf.workspace_symbol, desc = "list all symbols in the current workspace" },
      { "<leader>c[", vim.diagnostic.goto_prev, desc = "goto prev diagnostic" },
      { "<leader>c]", vim.diagnostic.goto_next, desc = "goto next diagnostic" },
    },
  },

  -- clangd
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "p00f/clangd_extensions.nvim",
    },
    init = function()
      require("clangd_extensions").setup({
        server = {
          -- options to pass to nvim-lspconfig
          -- i.e. the arguments to require("lspconfig").clangd.setup({})
          on_attach = function(_, buffer)
            vim.keymap.set(
              "n",
              "<LocalLeader>ci",
              "<cmd>ClangdSymbolInfo<cr>",
              { buffer = buffer, desc = "ClangdSymbolInfo" }
            )
            vim.keymap.set(
              "n",
              "<LocalLeader>ch",
              "<cmd>ClangdTypeHierarchy<cr>",
              { buffer = buffer, desc = "ClangdTypeHierarchy" }
            )
          end,
          cmd = {
            "clangd",
            "--offset-encoding=utf-16",
            "--background-index",
            "--clang-tidy",
            "--completion-style=bundled",
            "--cross-file-rename",
            "--header-insertion=iwyu",
            "--header-insertion-decorators",
            "--suggest-missing-includes",
            "--clang-tidy-checks=-*,bugprone-*,cert-*,clang-analyzer-*,cppcoreguidelines-*,misc-*,modernize-*,performance-*,portability-*,readability-*",
          },
        },
        extensions = {
          -- defaults:
          -- Automatically set inlay hints (type hints)
          autoSetHints = true,
          -- These apply to the default ClangdSetInlayHints command
          inlay_hints = {
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",
            -- whether to show parameter hints with the inlay hints or not
            show_parameter_hints = true,
            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment",
            -- The highlight group priority for extmark
            priority = 100,
          },
          ast = {
            -- These are unicode, should be available in any font
            role_icons = {
              type = "🄣",
              declaration = "🄓",
              expression = "🄔",
              statement = ";",
              specifier = "🄢",
              ["template argument"] = "🆃",
            },
            kind_icons = {
              Compound = "🄲",
              Recovery = "🅁",
              TranslationUnit = "🅄",
              PackExpansion = "🄿",
              TemplateTypeParm = "🅃",
              TemplateTemplateParm = "🅃",
              TemplateParamObject = "🅃",
            },
            highlights = {
              detail = "Comment",
            },
          },
          memory_usage = {
            border = "none",
          },
          symbol_info = {
            border = "none",
          },
        },
      })
    end,
    opts = {
      servers = {
        clangd = {},
      },
    },
  },

  -- CMake
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "Decodetalkers/neocmakelsp",
      init = function()
        local configs = require("lspconfig.configs")
        local nvim_lsp = require("lspconfig")
        if not configs.neocmake then
          configs.neocmake = {
            default_config = {
              cmd = { "neocmakelsp", "--stdio" },
              filetypes = { "cmake" },
              root_dir = function(fname)
                return nvim_lsp.util.find_git_ancestor(fname)
              end,
              single_file_support = true, -- suggested
              on_attach = function() end, -- on_attach is the on_attach function you defined
            },
          }
          nvim_lsp.neocmake.setup({})
        end
      end,
    },
  },

  -- Python
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "amirali/yapf.nvim",
      config = function()
        require("yapf").setup({})
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {
          on_attach = function(_, bufnr)
            vim.keymap.set("n", "<leader>cf", "<cmd>Yapf<cr>", { buffer = bufnr, desc = "Python Yapf format" })
          end,
        },
      },
    },
  },

  -- rust
  -- see https://sharksforarms.dev/posts/neovim-rust/
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "simrat39/rust-tools.nvim",
      lazy = true,
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
              -- RustRun
              vim.keymap.set("n", "<LocalLeader>r", "<cmd>RustRun<cr>", { desc = "RustRun" })
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
        -- TODO: fix go.nvim keymaps confiect
        lsp_keymaps = true, -- true: use default keymaps defined in go/lsp.lua
        lsp_inlay_hints = {
          other_hints_prefix = "",
        },
        lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
        lsp_on_attach = true, -- use on_attach from go.nvim
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- Java
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mfussenegger/nvim-jdtls",
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        jdtls = {
          filetypes = { "java" },
          single_file_support = true,
          on_attach = function(_, bufnr)
            -- TODO: fix here
            require("jdtls").start_or_attach({
              cmd = {
                "jdtls",
                "-javaHome",
                os.getenv("JAVA_HOME"),
                "-configuration",
                os.getenv("HOME") .. "/.cache/jdtls/config",
                "-data",
                os.getenv("HOME") .. "/.cache/jdtls/workspace",
              },
              filetypes = { "java" },
              on_attach = function(_, bufnr)
                -- stylua: ignore
                vim.keymap.set("n", "<LocalLeader>gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { buffer = bufnr })
                vim.keymap.set("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<cr>", { buffer = bufnr })
              end,
              settings = {
                java = {
                  signatureHelp = { enabled = true },
                  contentProvider = { preferred = "fernflower" },
                  sources = { default = os.getenv("JAVA_HOME") .. "/src.zip" },
                },
              },
            })
          end,
        },
      },
    },
  },

  -- typescript
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- Vue
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        volar = {
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
        },
      },
    },
  },
}
