return {
  "folke/which-key.nvim",
  lazy = false,
  opts = {},
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Which Key",
    },
  },
}
