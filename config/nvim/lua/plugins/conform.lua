return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      go = { "goimports", "gofmt" },
    },
    format_on_save = {},
    formatters = {
      goimports = {
        command = vim.fn.expand("~") .. "/go/bin/goimports"
      },
    },
  },
}
