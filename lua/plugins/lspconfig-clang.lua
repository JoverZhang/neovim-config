if  vim.fn.executable("clang") != 1 then
  return {}
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "p00f/clangd_extensions.nvim",
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
      },
    },
  },
}
