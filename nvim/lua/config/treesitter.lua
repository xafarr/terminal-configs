local install = require("nvim-treesitter.install")

local configs = require("nvim-treesitter.configs")

install.update({ with_sync = true })

configs.setup({
    ensure_installed = "all", -- one of "all" or a list of languages
    ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {}, -- list of language that will be disabled
        additional_vim_regex_highlighting = { "org" },
    },
    autopairs = {
        enable = true,
    },
    indent = {
        enable = true,
    },
})
