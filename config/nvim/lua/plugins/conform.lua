return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      go = { "goimports", "gofmt" },
      rust = { "rustfmt" },
    },
    format_on_save = {},
    formatters = {
      goimports = {
        command = vim.fn.expand("~") .. "/go/bin/goimports"
      },
    },
  },
}
