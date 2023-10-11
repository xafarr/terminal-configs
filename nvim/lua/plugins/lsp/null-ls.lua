return {
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
        config = function()
            local null_ls = require("null-ls")
            local mason_null_ls = require("mason-null-ls")

            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics
            local code_actions = null_ls.builtins.code_actions

            local sources = {
                -- Formatting
                formatting.terraform_fmt,
                formatting.xmllint,
                formatting.gofmt,

                -- Diagnostics
                diagnostics.tsc,

                -- Code Actions
                code_actions.gitsigns,
            }

            null_ls.setup({
                sources = sources,
            })

            mason_null_ls.setup({
                ensure_installed = {
                    -- Opt to list sources here, when available in mason.
                    "ansible-lint",
                    "beautysh",
                    "black",
                    "clang-format",
                    "eslint",
                    "flake8",
                    "flake8",
                    "google-java-format",
                    "jq",
                    "ktlint",
                    "markdownlint",
                    "prettier",
                    "shellcheck",
                    "shellcheck",
                    "sql-formatter",
                    "stylua",
                    "xmlformatter",
                },
                automatic_installation = false,
                handlers = {
                    markdownlint = function()
                        null_ls.register(null_ls.builtins.diagnostics.markdownlint.with({
                            extra_args = function(params)
                                local configPath = vim.fn.stdpath("config") .. "/markdownlint.json"
                                return { "--config", configPath }
                            end,
                        }))
                    end,
                },
            })
        end,
    },
}
