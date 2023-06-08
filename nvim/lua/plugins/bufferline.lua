return {
    {
        "akinsho/bufferline.nvim",
        lazy = false,
        dependendcies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            local bufferline = require("bufferline")
            local icons = require("config.icons")
            bufferline.setup({
                options = {
                    mode = "buffers",
                    indicator = {
                        style = "none",
                    },
                    buffer_close_icon = icons.ui.Close,
                    modified_icon = icons.git.Modified,
                    close_icon = icons.ui.BoldClose,
                    left_trunc_marker = icons.ArrowCircleLeft,
                    right_trunc_marker = icons.ArrowCircleRight,
                    max_name_length = 18,
                    max_prefix_length = 15,
                    diagnostics = "nvim_lsp",
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            highlight = "NvimTreeNormal",
                            text_align = "center",
                            separator = "█",
                        },
                    },
                    separator_style = "thin",
                },
            })
        end,
    },
}
