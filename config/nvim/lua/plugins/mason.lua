return {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-emoji",
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
        "tailwindcss",
        "ts_ls",
        "volar",
      },
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        local config = {
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
          root_dir = function(fname)
            return vim.fn.getcwd()
          end,
        }

        require("lspconfig")[server_name].setup(config)
      end,
    })

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
      }),
    })
  end,
}
