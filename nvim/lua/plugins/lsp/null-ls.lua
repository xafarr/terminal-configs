return {
    {
        "jay-babu/mason-null-ls.nvim",
        event = "BufRead",
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
        config = function()
            require("mason-null-ls").setup({
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
                    "yamlfmt",
                },
                automatic_installation = false,
                automatic_setup = true, -- Recommended, but optional
            })
            -- require("mason-null-ls").setup_handlers() -- If `automatic_setup` is true.
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "BufReadPre",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            local null_ls = require("null-ls")

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
        end,
    },
}
