local telescope = require("telescope")

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob",
      "!.git/*",
    },
  },
  pickers = {
    live_grep = {
      additional_args = function()
        return { "--hidden", "--glob", "!.git/*" }
      end,
    },
  },
})
