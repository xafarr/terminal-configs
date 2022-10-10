local highlight_colors = require("nvim-highlight-colors")

highlight_colors.setup({
    render = "background", -- or 'foreground' or 'first_column'
    enable_named_colors = true,
    enable_tailwind = false,
})
