local M = {}

function M.format(bufnr, range)
  local have_nls, _ = pcall(require, "nvimtools/none-ls.nvim")

  if have_nls then
    vim.lsp.buf.format({
      bufnr = bufnr,
      async = true,
      range = range,
      filter = function(client)
        if have_nls then
          return client.name == "null-ls"
        end
        return client.name ~= "null-ls"
      end,
    })
  else
    require("conform").format({
      bufnr = bufnr,
      async = true,
      lsp_fallback = true,
      range = range,
    })
  end
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
