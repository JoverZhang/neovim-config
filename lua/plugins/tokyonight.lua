local t = false

return {
  "folke/tokyonight.nvim",
  keys = {
    {
      "<leader>ut",
      function()
        local tokyonight = require("tokyonight")
        if t then
          tokyonight.setup()
        else
          tokyonight.setup({
            transparent = true,
            styles = {
              sidebars = "transparent",
              floats = "transparent",
            },
          })
        end

        t = not t
        vim.cmd("colorscheme tokyonight-night")
      end,
      desc = "tokyonight to transparent",
    },
  },
}
