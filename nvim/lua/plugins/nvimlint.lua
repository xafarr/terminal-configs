return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    local bufnr = vim.api.nvim_get_current_buf()

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      markdown = { "markdownlint-cli2" },
      mdx = { "markdownlint-cli2" },
      go = { "golangcilint" },
    }

    lint.linters["markdownlint-cli2"] = function()
      local efm = "%f:%l:%c %m,%f:%l %m"
      return {
        cmd = neoutils.IS_WINDOWS() and "markdownlint-cli2.cmd" or "markdownlint-cli2",
        ignore_exitcode = true,
        stream = "stderr",
        parser = require("lint.parser").from_errorformat(efm, {
          source = "markdownlint",
          severity = vim.diagnostic.severity.WARN,
        }),
        args = { "--config", neoconfigs.stdConfigPath .. "/.markdownlint.jsonc" },
      }
    end
  end,
}
