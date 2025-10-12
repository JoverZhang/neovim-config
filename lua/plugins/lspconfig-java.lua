vim.g.debug_mode = true

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "nvim-java/nvim-java",
      config = function()
        vim.notify("===nvim-java plugin loaded", vim.log.levels.INFO, { title = "nvim-java" })
        -- require("java").setup({
        --   -- list of file that exists in root of the project
        --   root_markers = {
        --     "settings.gradle",
        --     "settings.gradle.kts",
        --     "pom.xml",
        --     "build.gradle",
        --     "mvnw",
        --     "gradlew",
        --     "build.gradle.kts",
        --     ".git",
        --   },
        -- })
      end,
    },
  },
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      jdtls = {},
    },
  },
}
