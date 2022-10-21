local install = require("nvim-treesitter.install")

local configs = require("nvim-treesitter.configs")

install.update({ with_sync = true })

configs.setup({
    ensure_installed = "all", -- one of "all" or a list of languages
    ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
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
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
        },
    },
})
