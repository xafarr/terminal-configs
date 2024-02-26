local M = {}

function M.format(bufnr, range)
  local buf = bufnr or vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype
  local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

  vim.lsp.buf.format({
    bufnr = buf,
    async = false,
    range = range,
    filter = function(client)
      if have_nls then
        return client.name == "null-ls"
      end
      return client.name ~= "null-ls"
    end,
  })
end

-- Autoformat on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

function M.on_attach(client, bufnr)
  if client.supports_method("textDocument/formatting") then
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
end

return M
