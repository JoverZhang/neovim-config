-- add any tools you want to have installed below
return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "clangd",
      "cmakelang",
      "stylua",
      "shellcheck",
      "shfmt",
      "flake8",
    },
  },
}
