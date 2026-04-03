return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<leader>t", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Terminal (bottom)" },
    { "<leader>t", "<c-\\><c-n><cmd>ToggleTerm<cr>", mode = "t", desc = "Toggle Terminal" },
    { "<leader>tv", "<cmd>2ToggleTerm direction=vertical<cr>", desc = "Toggle Terminal (right)" },
    { "<leader>tv", "<c-\\><c-n><cmd>2ToggleTerm<cr>", mode = "t", desc = "Toggle Terminal (right)" },
  },
  opts = {
    direction = "horizontal",
  },
}
