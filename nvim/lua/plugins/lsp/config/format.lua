local M = {}

M.format_on_save = false

function M.toggle()
    M.format_on_save = not M.format_on_save
    vim.notify(M.autoformat and "Enabled format on save" or "Disabled format on save")
end

function M.format()
    local conform = require("conform")

    conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    })
end

--function M.on_attach(client, buf)
--    if client.supports_method("textDocument/formatting") then
--        vim.api.nvim_create_autocmd("BufWritePre", {
--            group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
--            buffer = buf,
--            callback = function()
--                if M.format_on_save then
--                    M.format()
--                end
--            end,
--        })
--    end
--end

return M
