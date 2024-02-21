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
                    local configPath = neoconfigs.stdConfigPath .. "/markdownlint.json"
                    return { "--config-path", configPath }
                end,
            }

            local sources = {
                -- Formatting
                formatting.terraform_fmt,
                formatting.xmllint,
                formatting.gofmt,
                formatting.black,
                formatting.isort,
                formatting.goimports,
                formatting.gofumpt,
                formatting.beautysh,
                formatting.clang_format,
                formatting.sql_formatter,
                formatting.xmlformat,
                formatting.google_java_format,
                formatting.markdownlint.with(markdown_extra_args),
                formatting.prettier.with({
                    diabled_filetypes = { "markdown" },
                }),
                formatting.stylua.with({
                    extra_args = function(_)
                        local configPath = neoconfigs.stdConfigPath .. "/stylua.toml"
                        return { "--config-path", configPath }
                    end,
                }),

                -- Diagnostics
                diagnostics.tsc,
                diagnostics.markdownlint.with(markdown_extra_args),
                diagnostics.ktlint,
                diagnostics.eslint_d,
                diagnostics.shellcheck,
                diagnostics.golangci_lint,
                diagnostics.ansiblelint,
                diagnostics.flake8,
                diagnostics.yamllint,
                diagnostics.terraform_validate,

                -- Code Actions
                code_actions.gitsigns,
                code_actions.eslint_d,
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
