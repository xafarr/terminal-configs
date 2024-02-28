return {
  "mfussenegger/nvim-lint",
  lazy = true,
  events = { "BufWritePost", "BufReadPost", "InsertLeave" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      markdown = { "markdownlint" },
      mdx = { "markdownlint" },
      svelte = { "eslint_d" },
      python = { "pylint" },
      terraform = { "tflint" },
      tf = { "tflint" },
      go = { "golangcilint" },
      bash = { "shellcheck" },
      sh = { "shellcheck" },
    }

    lint.linters.markdownlint = {
      args = { "--config", neoconfigs.stdConfigPath .. "/markdownlint.json" },
    }
  end,
}
