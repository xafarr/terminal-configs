return {
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local null_ls = require("null-ls")

            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics
            local code_actions = null_ls.builtins.code_actions
            local completion = null_ls.builtins.completion

            local markdown_extra_args = {
                extra_args = function(_)
                    local config = neoconfigs.stdConfigPath .. "/markdownlint.json"
                    return { "--config", config }
                end,
            }

            local sources = {
                -- Formatting
                formatting.beautysh,
                formatting.black,
                formatting.clang_format,
                formatting.gofumpt,
                formatting.goimports,
                formatting.google_java_format,
                formatting.isort,
                formatting.markdownlint.with(markdown_extra_args),
                formatting.prettier.with({
                    disabled_filetypes = { "markdown", "yaml" },
                }),
                formatting.sql_formatter,
                formatting.stylua.with({
                    extra_args = function(_)
                        local configPath = neoconfigs.stdConfigPath .. "/stylua.toml"
                        return { "--config-path", configPath }
                    end,
                }),
                formatting.terraform_fmt,
                formatting.xmlformat,
                formatting.xmllint,
                formatting.yamlfmt,

                -- Diagnostics
                diagnostics.ansiblelint,
                diagnostics.eslint_d,
                diagnostics.flake8,
                diagnostics.golangci_lint,
                diagnostics.ktlint,
                diagnostics.markdownlint.with(markdown_extra_args),
                diagnostics.shellcheck,
                diagnostics.terraform_validate,
                diagnostics.tsc,
                --diagnostics.yamllint,

                -- Code Actions
                code_actions.eslint_d,
                code_actions.gitsigns,
                code_actions.refactoring,
                code_actions.shellcheck,

                -- Completion
                completion.luasnip,
            }

            null_ls.setup({
                sources = sources,
            })
        end,
    },
}
