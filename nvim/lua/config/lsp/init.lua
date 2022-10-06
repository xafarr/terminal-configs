local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local illuminate = require("illuminate")

local servers = {
    "sumneko_lua",
    "jsonls",
    "tsserver",
    "ansiblels",
    "dockerls",
    "bashls",
    "terraformls",
    "kotlin_language_server",
    "pyright",
    "gopls",
}

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
        },
    },
})

mason_lspconfig.setup({
    ensure_installed = servers,
})

local on_attach = function(client, bufnr)
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        -- disable virtual text
        virtual_text = false,
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
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
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        width = 60,
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
        width = 60,
    })

    illuminate.on_attach(client)

    local function keymap(...)
        vim.keymap.set(...)
    end

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = { noremap = true, silent = true, buffer = bufnr }

    keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
    keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
    keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
    keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
    keymap("n", "<C-p>", ":lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
    keymap("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)
    keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
    keymap("n", "<leader>D", ":lua vim.lsp.buf.type_definition()<CR>", opts)
    keymap("n", "<leader>gl", ':lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
    keymap("n", "[d", ':lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    keymap("n", "]d", ':lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    keymap("n", "<leader>lq", ":lua vim.diagnostic.setloclist()<CR>", opts)
    keymap("n", "<leader>,", ":lua require('config.custom-functions').format(" .. bufnr .. ")<CR>", opts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

for _, server in pairs(servers) do
    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
    }
    local has_custom_opts, server_custom_opts = pcall(require, "config.lsp.settings." .. server)
    if has_custom_opts then
        opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
    end
    lspconfig[server].setup(opts)
end
