return {
  {
    "phaazon/hop.nvim",
    config = function()
      require("hop").setup({
        keys = "etovxqpdygfblzhckisuran",
      })
    end,
    keys = function()
      return {
        { "f", "<cmd>:HopAnywhereAC<cr>", desc = "HopAnywereAC" },
        { "F", "<cmd>:HopAnywhereBC<cr>", desc = "HopAnywereBC" },
        -- { "t", "<cmd>:HopAnywhereCurrentLineAC<cr>", desc = "HopAnywhereCurrentLineAC" },
        -- { "T", "<cmd>:HopAnywhereCurrentLineBC<cr>", desc = "HopAnywhereCurrentLineBC" },
      }
    end,
  },
  {
    "ggandor/flit.nvim",
    enabled = false,
    keys = function()
      ---@type LazyKeys[]
      local ret = {}
      for _, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },
}
