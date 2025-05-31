return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      },
    },
    "mason-org/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    {
      "folke/neodev.nvim",
      opts = {
        library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
      },
    },
    -- Useful status updates for LSP
    { "j-hui/fidget.nvim", opts = {} },
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    -- import cmp-nvim-lsp plugin
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

    local diagnostics = require("plugins.lsp.config.diagnostics")
    local formatter = require("plugins.lsp.config.formatter")

    -- Setup diagnostics
    diagnostics.setup_diagnostics()

    -- Used to enable autocompletion
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities() or {}
    )

    vim.lsp.config("*", {
      on_attach = neoutils.on_attach(function(client, bufnr)
        formatter.on_attach(client, bufnr)
        if client:supports_method("textDocument/semanticTokens") then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end),
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    })

    for _, server in ipairs(neoconfigs.language_servers) do
      local extend, user_config = pcall(require, "plugins.lsp.servers." .. server)
      if extend then
        vim.lsp.config(server, user_config.setup_and_get_config())
      end
    end

    -- Setup neodev lua configuration
    require("neodev").setup({
      library = { plugins = { "nvim-dap-ui" }, types = true },
    })

    mason_lspconfig.setup({
      ensure_installed = neoconfigs.language_servers,
      automatic_enable = { exclude = { "jdtls" } },
    })

    mason_tool_installer.setup({
      ensure_installed = neoconfigs.mason_tools,
    })

    -- Globally configure all LSP floating preview popups (like hover, signature help, etc)
    local open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded" -- Set border to rounded
      return open_floating_preview(contents, syntax, opts, ...)
    end
  end,
}
