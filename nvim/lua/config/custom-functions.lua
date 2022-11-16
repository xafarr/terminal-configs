M = {}
M.format = function(bufnr)
    vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(client)
            return client.name == "null-ls" or client.name == "dockerls"
        end,
        async = true,
    })
end
return M
