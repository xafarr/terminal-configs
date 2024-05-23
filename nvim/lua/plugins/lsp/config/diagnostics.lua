local M = {}
local icons = require("config.icons")

function M.setup_diagnostics()
  local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.BoldError },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.BoldWarning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.BoldHint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.BoldInformation },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    diagnostics = {
      -- disable virtual text
      virtual_text = false,
      -- show signs
      signs = {
        active = signs,
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
