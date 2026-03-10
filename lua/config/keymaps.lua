-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local groups = { "Normal", "NormalNC", "SignColumn", "EndOfBuffer", "NormalFloat", "FloatBorder" }

local function set_transparent(on)
  if on then
    for _, g in ipairs(groups) do
      vim.api.nvim_set_hl(0, g, { bg = "none" })
    end
  else
    local cs = vim.g.colors_name
    if cs then
      vim.cmd.colorscheme(cs)
    end
  end
end

vim.g.__transparent_enabled = vim.g.__transparent_enabled or false

vim.keymap.set("n", "<leader>ut", function()
  vim.g.__transparent_enabled = not vim.g.__transparent_enabled
  set_transparent(vim.g.__transparent_enabled)
  vim.notify("Transparent: " .. tostring(vim.g.__transparent_enabled))
end, { desc = "Toggle Transparent Background" })
