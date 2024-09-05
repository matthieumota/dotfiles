return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Toggle Telescope Find Files" },
    { "<leader>p", "<cmd>Telescope live_grep<cr>", desc = "Toggle Telescope Live Grep" },
    { "<leader>ff", "<cmd>Telescope find_files no_ignore=true<cr>", desc = "Toggle Telescope Find Files No Ignore" },
    { "<leader>pp", ":lua require(\"telescope.builtin\").live_grep({ additional_args = function() return {\"--no-ignore\"} end })<cr>", desc = "Toggle Telescope Live Grep No Ignore" },
  },
}
