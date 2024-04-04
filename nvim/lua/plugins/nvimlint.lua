return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    local bufnr = vim.api.nvim_get_current_buf()

    -- Attach LSP Keymaps
    require("plugins.lsp.config.keymaps").on_attach(nil, bufnr)

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      markdown = { "markdownlint" },
      mdx = { "markdownlint" },
      go = { "golangcilint" },
    }

    lint.linters.markdownlint = function()
      local efm = "%f:%l:%c %m,%f:%l %m"
      return {
        cmd = neoutils.IS_WINDOWS() and "markdownlint.cmd" or "markdownlint",
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
