-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

require("which-key").register({
  ["<localLeader>c"] = { name = "code" },
  ["<leader>d"] = { name = "debug" },
  ["<leader>t"] = { name = "terminal" },
})

vim.keymap.set("n", "<leader>qc", function()
  vim.cmd("cd %:p:h")
  vim.notify("cwd change to: " .. vim.fn.getcwd())
  require("plugins.exts.sessions").load()
end, { desc = "Change cwd and load session" })
