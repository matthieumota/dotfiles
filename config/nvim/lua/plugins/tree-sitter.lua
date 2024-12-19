return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    { "windwp/nvim-ts-autotag" },
  },
  opts = {
    ensure_installed = {
      "bash",
      "css",
      "gitignore",
      "go",
      "html",
      "lua",
      "javascript",
      "json",
      "markdown",
      "php",
      "rust",
      "sql",
      "typescript",
      "vue",
      "yaml",
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    require("nvim-ts-autotag").setup()

    vim.filetype.add({
      extension = {
        edge = "html",
      },
    })
  end
}
