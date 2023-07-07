return {
  "kelly-lin/ranger.nvim",
  config = function()
    require("ranger-nvim").setup({ replace_netrw = true })
    -- vim.api.nvim_set_keymap("n", "<leader><c-f>", "", {
    --   noremap = true,
    --   callback = function()
    --     require("ranger-nvim").open(true)
    --   end,
    -- })
  end,
  keys = {
    {
      "<leader><c-f>",
      function()
        require("ranger-nvim").open(true)
      end,
      desc = "Open ranger",
    },
  },
}
