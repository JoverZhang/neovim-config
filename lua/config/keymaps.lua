-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

require("which-key").register({
  ["<localLeader>c"] = { name = "code" },
  ["<leader>d"] = { name = "debug" },
  ["<leader>t"] = { name = "terminal" },
})

-- sessions
vim.keymap.set("n", "<leader>qc", function()
  vim.cmd("cd %:p:h")
  vim.notify("cwd change to: " .. vim.fn.getcwd())
end, { desc = "Change cwd to current directory" })
vim.keymap.set("n", "<leader>qr", function()
  require("plugins.exts.sessions").load_recent(true)
end, { desc = "Recent Session" })

-- tab navigation
vim.keymap.set("n", "<leader>th", "<cmd>tabprevious<cr>", { desc = "tab previous" })
vim.keymap.set("n", "<leader>tl", "<cmd>tabnext<cr>", { desc = "tab next" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "tab new" })
vim.keymap.set("n", "<leader>td", "<cmd>tabclose<cr>", { desc = "tab close" })

-- use alt+{h,j,k,l} to move cursor in insert mode
vim.keymap.set("i", "<A-h>", "<Left>", { noremap = false })
vim.keymap.set("i", "<A-j>", "<Down>", { noremap = false })
vim.keymap.set("i", "<A-k>", "<Up>", { noremap = false })
vim.keymap.set("i", "<A-l>", "<Right>", { noremap = false })
