vim.g.debug_mode = true

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "nvim-java/nvim-java",
      config = function()
        -- Fix for lombok missing
        -- ln -s \
        --     $HOME/.local/share/nvim/mason/packages/lombok-nightly/lombok.jar \
        --     $HOME/.local/share/nvim/mason/share/jdtls/lombok.jar
        require("java").setup({
          -- list of file that exists in root of the project
          root_markers = {
            "settings.gradle",
            "settings.gradle.kts",
            "pom.xml",
            "build.gradle",
            "mvnw",
            "gradlew",
            "build.gradle.kts",
            ".git",
          },
        })
      end,
    },
  },
}
