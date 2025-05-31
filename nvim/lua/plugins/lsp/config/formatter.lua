local M = {}

function M.format(bufnr, range)
  require("conform").format({
    bufnr = bufnr,
    async = true,
    range = range,
  })
end

-- Autoformat on save
function M.on_attach(_, bufnr)
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      if not neoconfigs.format_on_save then
        return
      end
      M.format(bufnr)
    end,
  })
end

return M
