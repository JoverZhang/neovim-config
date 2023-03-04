return {
  "stevearc/overseer.nvim",
  init = function()
    require("overseer").setup({
      templates = { "builtin", "user.cpp_build" },
    })
  end,
}
