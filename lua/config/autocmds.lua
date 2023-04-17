-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- autocmd BufNewFile,BufRead *.fmtmd set filetype=fmtmd

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.water",
  callback = function(_)
    vim.cmd("set filetype=rust")
    vim.cmd("set tabstop=2")
    vim.cmd("set shiftwidth=2")
  end,
})

local language_textwidths = {
  c = 80,
  cpp = 120,
  go = 120,
  lua = 120,
  python = 80,
  rust = 120,

  -- Markup language
  text = 80,
  json = 80,
  markdown = 80,
}

vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function(opts)
    local textwidth = language_textwidths[vim.bo[opts.buf].filetype]
    if textwidth then
      vim.cmd("set textwidth=" .. textwidth)
    end
  end,
})
