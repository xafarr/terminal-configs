local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local sources = {
    -- Formatting
    formatting.eslint,
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.stylua,
    formatting.clang_format,
    formatting.prettier,
    formatting.ktlint,
    formatting.terraform_fmt,
    formatting.jq,
    formatting.xmllint,
    formatting.google_java_format,
    formatting.yamlfmt,
    formatting.beautysh,
    formatting.markdownlint,
    formatting.gofmt,

    -- Diagnostics
    diagnostics.markdownlint,
    diagnostics.ansiblelint,
    diagnostics.flake8,
    diagnostics.ktlint,
    diagnostics.shellcheck,
    diagnostics.tsc,

    -- Code Actions
    code_actions.gitsigns,
}

null_ls.setup({
    sources = sources,
})
