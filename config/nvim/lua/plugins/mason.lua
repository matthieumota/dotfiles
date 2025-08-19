return {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
  },
  config = function()
    local cmp = require("cmp")
    local mason_lspconfig = require("mason-lspconfig")

    require("mason").setup()

    mason_lspconfig.setup({
      ensure_installed = {
        "cssls",
        "emmet_language_server",
        "gopls",
        "html",
        "lua_ls",
        "intelephense",
        "pylsp",
        "rust_analyzer",
        "tailwindcss",
        "ts_ls",
        "vue_ls",
      },
    })

    require("lspconfig")["ts_ls"].setup {
      init_options = {
        plugins = {
          {
            name = '@vue/typescript-plugin',
            location = "",
            languages = { 'vue' },
          },
        },
      },
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    }

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end),
        ["<C-Space>"] = cmp.mapping(function(fallback)
          if vim.lsp.buf.signature_help then
            vim.lsp.buf.signature_help()
          else
            fallback()
          end
        end),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "emoji" },
        { name = "path" },
        { name = "buffer", option = { get_bufnrs = vim.api.nvim_list_bufs } },
      }),
    })
  end,
}
