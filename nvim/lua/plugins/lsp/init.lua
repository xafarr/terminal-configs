return {
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            {
                "folke/neodev.nvim",
                opts = {
                    library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
                },
            },
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
        },
        config = function()
            -- Setup neovim lua configuration
            require("neodev").setup()

            local lspconfig = require("lspconfig")
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")

            local servers = {
                "angularls",
                "ansiblels",
                "bashls",
                "clangd",
                "cmake",
                "csharp_ls",
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

            mason.setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                    },
                },
            })

            mason_lspconfig.setup({
                ensure_installed = servers,
            })

            local on_attach = function(client, bufnr)
                local signs = {
                    { name = "DiagnosticSignError", text = "" },
                    { name = "DiagnosticSignWarn", text = "" },
                    { name = "DiagnosticSignHint", text = "" },
                    { name = "DiagnosticSignInfo", text = "" },
                }

                for _, sign in ipairs(signs) do
                    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
                end

                local config = {
                    -- disable virtual text
                    virtual_text = false,
                    -- show signs
                    signs = {
                        active = signs,
                    },
                    update_in_insert = true,
                    underline = true,
                    severity_sort = true,
                    float = {
                        focusable = false,
                        style = "minimal",
                        border = "rounded",
                        source = "always",
                        header = "",
                        prefix = "",
                    },
                }

                vim.diagnostic.config(config)

                vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                    border = "rounded",
                    width = 60,
                })

                vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                    border = "rounded",
                    width = 60,
                })

                local function keymap(...)
                    vim.keymap.set(...)
                end

                local function buf_set_option(...)
                    vim.api.nvim_buf_set_option(bufnr, ...)
                end

                buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

                local opts = { noremap = true, silent = true, buffer = bufnr }

                keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
                keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
                keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
                keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
                keymap("n", "<C-p>", ":lua vim.lsp.buf.signature_help()<CR>", opts)
                keymap("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
                keymap("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)
                keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
                keymap("n", "<leader>D", ":lua vim.lsp.buf.type_definition()<CR>", opts)
                keymap("n", "<leader>gl", ':lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
                keymap("n", "[d", ':lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
                keymap("n", "]d", ':lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
                keymap("n", "<leader>lq", ":lua vim.diagnostic.setloclist()<CR>", opts)
                keymap("n", "<leader>,", ":lua require('utils').format()<CR>", opts)
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            local lsp_opts = {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            for _, server in pairs(servers) do
                local has_custom_opts, server_custom_opts = pcall(require, "plugins.lsp.settings." .. server)
                if has_custom_opts then
                    lsp_opts = vim.tbl_deep_extend("force", lsp_opts, server_custom_opts)
                end
                lspconfig[server].setup(lsp_opts)
            end
        end,
    },
    -- {
    --   "williamboman/mason.nvim",
    --   cmd = "Mason",
    --   keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    --   opts = {
    --     ensure_installed = {
    --       "stylua",
    --       "ruff",
    --       "debugpy",
    --       "codelldb",
    --     },
    --   },
    --   config = function(_, opts)
    --     require("mason").setup()
    --     local mr = require "mason-registry"
    --     for _, tool in ipairs(opts.ensure_installed) do
    --       local p = mr.get_package(tool)
    --       if not p:is_installed() then
    --         p:install()
    --       end
    --     end
    --   end,
    -- },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "BufReadPre",
        dependencies = { "mason.nvim" },
        config = function()
            local null_ls = require("null-ls")

            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics
            local code_actions = null_ls.builtins.code_actions

            local sources = {
                -- Formatting
                formatting.eslint,
                formatting.black.with({ extra_args = { "--fast" } }),
                formatting.stylua,
                formatting.clang_format,
                formatting.prettier,
                formatting.ktlint,
                formatting.terraform_fmt,
                formatting.jq,
                formatting.xmllint,
                formatting.google_java_format,
                formatting.yamlfmt,
                formatting.beautysh,
                formatting.markdownlint,
                formatting.gofmt,
                formatting.sql_formatter,

                -- Diagnostics
                diagnostics.markdownlint,
                diagnostics.ansiblelint,
                diagnostics.flake8,
                diagnostics.ktlint,
                diagnostics.shellcheck,
                diagnostics.tsc,

                -- Code Actions
                code_actions.gitsigns,
            }

            null_ls.setup({
                sources = sources,
            })
        end,
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
