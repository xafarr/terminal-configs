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
          mdx = { "markdownlint" },
          python = { "isort", "black" },
          sql = { "sql_formatter" },
          svelte = { "prettier" },
          terraform = { "terraform_fmt" },
          tf = { "terraform_fmt" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          xml = { "xmlformat" },
          yaml = { "yamlfmt" },
          bash = { "beautysh" },
          sh = { "beautysh" },
          zsh = { "beautysh" },
          csharp = { "csharpier" },
          cs = { "csharpier" },
          kotlin = { "ktlint" },
          kt = { "ktlint" },
        },
        formatters = {
          markdownlint = {
            prepend_args = { "--config", neoconfigs.stdConfigPath .. "/markdownlint.json" },
          },
        },
      })
    end,
  },
}
