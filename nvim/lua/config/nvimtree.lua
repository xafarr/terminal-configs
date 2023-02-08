-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local nvim_tree = require("nvim-tree")
local nvim_tree_config = require("nvim-tree.config")

local tree_cb = nvim_tree_config.nvim_tree_callback

local function open_nvim_tree(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    if not directory then
        return
    end

    -- create a new, empty buffer
    vim.cmd.enew()

    -- wipe the directory buffer
    vim.cmd.bw(data.buf)

    -- change to the directory
    vim.cmd.cd(data.file)

    -- open the tree
    require("nvim-tree.api").tree.open()
end

-- NvimTree start up
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

nvim_tree.setup({
    remove_keymaps = { "<Tab>" },
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    git = {
        ignore = false,
    },
    renderer = {
        highlight_git = true,
        indent_markers = {
            enable = true,
        },
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_open = "▾",
                    arrow_closed = "▸",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "",
                },
            },
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
    actions = {
        open_file = {
            resize_window = true,
        },
    },

    view = {
        width = 30,
        side = "left",
        mappings = {
            list = {
                { key = { "<CR>" }, cb = tree_cb("edit") },
                { key = "<C-v>", cb = tree_cb("vsplit") },
            },
        },
    },
})
