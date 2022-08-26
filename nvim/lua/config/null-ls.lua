local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting

local sources = {
	formatting.eslint,
	formatting.black,
	formatting.stylua,
	formatting.clang_format,
	formatting.prettier,
	formatting.ktlint,
	formatting.terraform_fmt,
}

null_ls.setup({
	sources = sources,
})
