M = {}
M.format = function(bufnr)
    vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(client)
            return client.name == "null-ls"
        end,
    })
end
return M

