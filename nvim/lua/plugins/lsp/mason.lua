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
        },
        config = function()
            -- Setup neovim lua configuration
            require("neodev").setup({
                library = { plugins = { "nvim-dap-ui" }, types = true },
            })

            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")

            local servers = {
                "angularls",
                "ansiblels",
                "bashls",
                "bicep-lsp",
                "clangd",
                "cmake",
                "cssls",
                "cucumber_language_server",
                "docker_compose_language_service",
                "dockerls",
                "golangci_lint_ls",
                "gopls",
                "gradle_ls",
                "graphql",
                "groovyls",
                "html",
                "jdtls",
                "jsonls",
                "kotlin_language_server",
                "lemminx",
                "lua_ls",
                "omnisharp",
                "pyright",
                "ruby_ls",
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
                    },
                },
            })

            mason_lspconfig.setup({
                ensure_installed = servers,
            })

            mason_lspconfig.setup_handlers({
                function(server)
                    local lsp_utils = require("plugins.lsp.config.utils")
                    local lsp_opts = {
                        capabilities = lsp_utils.capabilities(),
                        on_attach = lsp_utils.on_attach(function(client, buffer)
                            require("plugins.lsp.config.diagnostics").on_attach()
                            require("plugins.lsp.config.format").on_attach(client, buffer)
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
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
    },
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = { use_diagnostic_signs = true },
        keys = {
            { "<leader>cd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
            { "<leader>cD", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
        },
    },
}
