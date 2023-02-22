-- add any tools you want to have installed below
return {
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
}
