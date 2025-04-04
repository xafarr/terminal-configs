local M = {}
local icons = require("config.icons")

function M.setup_diagnostics()
  local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.BoldError },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.BoldWarning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.BoldHint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.BoldInformation },
  }

  local config = {
    diagnostics = {
      -- disable virtual text
      virtual_text = false,
      -- show signs
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.diagnostics.BoldError,
          [vim.diagnostic.severity.WARN] = icons.diagnostics.BoldWarning,
          [vim.diagnostic.severity.INFO] = icons.diagnostics.BoldInformation,
          [vim.diagnostic.severity.HINT] = icons.diagnostics.BoldHint,
        },
      },
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    },
    float = {
      focusable = true,
      border = "rounded",
      style = "minimal",
      width = 60,
    },
  }

  vim.diagnostic.config(config.diagnostics)
end

return M
