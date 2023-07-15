if vim.g.neovide then
  vim.o.guifont = "JetBrains Mono:h11" -- text below applies for VimScript
  vim.g.neovide_transparency = 1
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_profiler = false
  vim.g.neovide_refresh_rate = 100

  vim.api.nvim_set_keymap("i", "<c-s-v>", "<c-r>+", { noremap = true })
  vim.api.nvim_set_keymap("c", "<c-s-v>", "<c-r>+", { noremap = true })
end
