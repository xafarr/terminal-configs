return {
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        cmd = "Mason",
        dependencies = {
            {
                "folke/neodev.nvim",
                opts = {
                    library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
                },
            },
            "neovim/nvim-lspconfig",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            -- Setup neovim lua configuration
            require("neodev").setup({
                library = { plugins = { "nvim-dap-ui" }, types = true },
            })

            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")
            local mason_tool_installer = require("mason-tool-installer")

            local language_servers = {
                "angularls",
                "ansiblels",
                "bashls",
                "bicep",
                "clangd",
                "cmake",
                "csharp_ls",
                "cssls",
                "dockerls",
                "gopls",
                "gradle_ls",
                "graphql",
                "groovyls",
                "html",
                "jdtls", -- Java Language Server
                "jsonls",
                "kotlin_language_server",
                "lemminx", -- XML Language Server
                "lua_ls",
                "pyright",
                "rust_analyzer",
                "sqlls",
                "terraformls",
                "tsserver",
                "vimls",
                "vuels",
                "yamlls",
            }

            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            mason_lspconfig.setup({
                ensure_installed = language_servers,
            })

            mason_lspconfig.setup_handlers({
                function(server)
                    local lsp_utils = require("plugins.lsp.config.utils")
                    local lsp_opts = {
                        capabilities = lsp_utils.capabilities(),
                        on_attach = lsp_utils.on_attach(function(client, buffer)
                            require("plugins.lsp.config.diagnostics").on_attach()
                            --require("plugins.lsp.config.format").on_attach(client, buffer)
                            require("plugins.lsp.config.keymaps").on_attach(client, buffer)
                        end),
                    }
                    local has_custom_opts, server_custom_opts = pcall(require, "plugins.lsp.servers." .. server)
                    if has_custom_opts then
                        lsp_opts = vim.tbl_deep_extend("force", lsp_opts, server_custom_opts)
                    end
                    lspconfig[server].setup(lsp_opts)
                end,
            })

            mason_tool_installer.setup({
                ensure_installed = {
                    -- List formatters and linters here, when available in mason.
                    "ansible-lint",
                    "beautysh",
                    "black",
                    "clang-format",
                    "eslint_d",
                    "flake8",
                    "golangci-lint",
                    "google-java-format",
                    "isort",
                    "jq",
                    "ktlint",
                    "markdownlint",
                    "prettier",
                    "pylint",
                    "shellcheck",
                    "sql-formatter",
                    "stylua",
                    "tflint",
                    "xmlformatter",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
        config = function() end,
    },
}
