return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    {
      "folke/neodev.nvim",
      opts = {
        library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
      },
    },
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local diagnostics = require("plugins.lsp.config.diagnostics")
    local keymaps = require("plugins.lsp.config.keymaps")
    local formatter = require("plugins.lsp.config.formatter")

    -- Setup diagnostics
    diagnostics.setup_diagnostics()

    -- Used to enable autocompletion
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Setup neovim lua configuration
    require("neodev").setup({
      library = { plugins = { "nvim-dap-ui" }, types = true },
    })

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_tool_installer.setup({
      ensure_installed = neoconfigs.formatters_and_linters,
    })

    mason_lspconfig.setup({
      ensure_installed = neoconfigs.language_servers,
      automatic_installation = false,
      handlers = {
        function(server)
          local opts = {
            -- Attach keymaps and formatter to LSP
            on_attach = function(client, bufnr)
              keymaps.on_attach(client, bufnr)
              formatter.on_attach(client, bufnr)
            end,
            capabilities = capabilities,
            flags = {
              debounce_text_changes = 150,
            },
          }

          local extend, user_opts = pcall(require, "plugins.lsp.servers." .. server)

          if extend then
            opts = vim.tbl_deep_extend("force", opts, user_opts)
          end

          lspconfig[server].setup(opts)
        end,
      },
    })
  end,
}
