local t = false

return {
  "folke/tokyonight.nvim",
  keys = {
    {
      "<leader>ut",
      function()
        local tokyonight = require("tokyonight")
        -- opaque
        if t then
          tokyonight.setup()
          -- neovide
          if vim.g.neovide then
            vim.g.neovide_transparency = 1
          end

        -- transparent
        else
          tokyonight.setup({
            transparent = true,
            styles = {
              sidebars = "transparent",
              floats = "transparent",
            },
          })
          -- neovide
          if vim.g.neovide then
            vim.g.neovide_transparency = 0.8
          end
        end

        t = not t
        vim.cmd("colorscheme tokyonight-night")
      end,
      desc = "tokyonight to transparent",
    },
  },
}
