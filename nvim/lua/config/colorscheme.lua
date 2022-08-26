local nightfox = require("nightfox")

nightfox.setup({
    dim_inactive = true,
    options = {
        styles = {
            comments = "italic",
            keywords = "bold",
            functions = "italic",
        },
        inverse = {
            search = true,
            match_paren = true,
        },
        modules = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            telescope = true,
        },
    },
})

-- Colorscheme
vim.cmd("colorscheme nordfox")
