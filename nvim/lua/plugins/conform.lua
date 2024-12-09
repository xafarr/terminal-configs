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
          groovy = { "npm-groovy-lint" },
          html = { "prettier" },
          java = { "google-java-format" },
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          json = { "prettier" },
          lua = { "stylua" },
          markdown = { "markdownlint-cli2" },
          mdx = { "markdownlint-cli2" },
          python = { "isort", "black" },
          sql = { "sql_formatter" },
          svelte = { "prettier" },
          terraform = { "terraform_fmt" },
          tf = { "terraform_fmt" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          xml = { "xmlformat" },
          yaml = { "yamlfmt" },
          bash = { "shfmt" },
          sh = { "shfmt" },
          zsh = { "shfmt" },
          csharp = { "csharpier" },
          cs = { "csharpier" },
          kotlin = { "ktlint" },
          kt = { "ktlint" },
        },
        formatters = {
          ["markdownlint-cli2"] = {
            prepend_args = { "--config", neoconfigs.stdConfigPath .. "/.markdownlint.jsonc" },
          },
          shfmt = {
            prepend_args = { "-i", "4" },
          },
          yamlfmt = {
            prepend_args = { "-conf", neoconfigs.stdConfigPath .. "/.yamlfmt.yaml" },
          },
        },
      })
    end,
  },
}
