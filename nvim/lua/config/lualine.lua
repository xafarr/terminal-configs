local lualine = require("lualine")

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic", "coc" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = false,
    update_in_insert = false,
    always_visible = true,
}

local diff = {
    "diff",
    colored = false,
    diff_color = {
        -- Same color values as the general color option can be used here.
        added = "DiffAdd", -- Changes the diff's added color
        modified = "DiffChange", -- Changes the diff's modified color
        removed = "DiffDelete", -- Changes the diff's removed color you
    },
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width,
}

local mode = {
    "mode",
    fmt = function(str)
        return str
    end,
}

local filetype = {
    "filetype",
    icons_enabled = true,
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
}

-- total lines
local total_lines = function()
    return vim.fn.line("$")
end

-- location in file
local location = function()
    local line = vim.fn.line(".")
    local col = vim.fn.col(".")
    return string.format("%d:%d/%d", line, col, total_lines())
end

local filename = {
    "filename",
    path = 1,
}

-- cool function for progress
local progress = function()
    local current_line = vim.fn.line(".")
    local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines()
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
end

local spaces = function()
    return "spaces:" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = "edge",
        --component_separators = { left = '', right = ''},
        --section_separators = { left = '', right = ''},
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
    },
    globalstatus = true,
    refresh = {
        statusline = 300,
        tabline = 300,
        winbar = 300,
    },
    sections = {
        lualine_a = { mode },
        lualine_b = { branch, diff },
        lualine_c = { filename },
        lualine_x = { diagnostics, spaces, filetype },
        lualine_y = { location },
        lualine_z = { progress },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    extensions = { "nvim-tree", "fugitive", "quickfix", "toggleterm" },
})
