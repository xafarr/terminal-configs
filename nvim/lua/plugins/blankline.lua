return {
    {
        "lukas-reineke/indent-blankline.nvim", -- indentation guides to all lines
        dependencies = {},
        lazy = false,
        main = "ibl",
        config = function()
            local blankline = require("ibl")
            local icons = require("config.icons")

            blankline.setup({
                scope = {
                    enabled = true,
                    show_start = true,
                    show_end = true,
                    include = {
                        node_type = { ["*"] = { "*" } },
                    },
                },
                indent = {
                    char = icons.ui.LineMiddle,
                },
            })
        end,
    },
}
