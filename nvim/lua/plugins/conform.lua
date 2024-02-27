return {
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local conform = require("conform")
            conform.setup({
                formatters_by_ft = {
                    -- Conform will run multiple formatters sequentially
                    --  go = { "goimports", "gofmt" },
                    -- Use a sub-list to run only the first available formatter
                    --  javascript = { { "prettierd", "prettier" } },
                    css = { "prettier" },
                    go = { "goimports", "gofumpt" },
                    graphql = { "prettier" },
                    html = { "prettier" },
                    java = { "google-java-format" },
                    javascript = { "prettier" },
                    javascriptreact = { "prettier" },
                    json = { "prettier" },
                    lua = { "stylua" },
                    markdown = { "markdownlint" },
                    python = { "isort", "black" },
                    sql = { "sql-formatter" },
                    svelte = { "prettier" },
                    terraform = { "terraform_fmt" },
                    typescript = { "prettier" },
                    typescriptreact = { "prettier" },
                    xml = { "xmlformatter" },
                    yaml = { "prettier" },
                },
            })
        end,
    },
}
