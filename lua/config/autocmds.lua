-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local language_textwidths = {
  c = 80,
  cpp = 120,
  go = 120,
  lua = 120,
  python = 80,
  rust = 120,
}

vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function(opts)
    local textwidth = language_textwidths[vim.bo[opts.buf].filetype]
    if textwidth then
      vim.cmd("set textwidth=" .. textwidth)
    end
  end,
})
