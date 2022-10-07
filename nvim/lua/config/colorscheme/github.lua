local github = require("github-theme")

github.setup({
    colors = {},
    comment_style = "italic",
    dark_float = false,
    dark_sidebar = true,
    dev = false,
    function_style = "NONE",
    hide_end_of_buffer = true,
    hide_inactive_statusline = true,
    keyword_style = "italic",
    msg_area_style = "NONE",
    overrides = function()
        return {}
    end,
    sidebars = {},
    theme_style = "light",
    transparent = false,
    variable_style = "NONE",
})
