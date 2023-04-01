return {
  "akinsho/toggleterm.nvim",
  init = function()
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
  opts = {},
  keys = {
    -- { "<leader>th", "<cmd>ToggleTermToggleAll<cr>", desc = "ToggleTermToggleAll" },
    { "<leader>ts", "<cmd>ToggleTerm 1 direction=horizontal<cr>", desc = "ToggleTerm horizontal" },
    { "<leader>t1", "<cmd>ToggleTerm 1 direction=horizontal<cr>", desc = "ToggleTerm 1" },
    { "<leader>t2", "<cmd>ToggleTerm 2 direction=horizontal<cr>", desc = "ToggleTerm 2" },
    { "<leader>t3", "<cmd>ToggleTerm 3 direction=horizontal<cr>", desc = "ToggleTerm 3" },
    { "<leader>tv", "<cmd>ToggleTerm 10 direction=vertical<cr>", desc = "ToggleTerm vertical 10" },
    { "<leader>tf", "<cmd>ToggleTerm 11 direction=float<cr>", desc = "ToggleTerm float 11" },
  },
}
