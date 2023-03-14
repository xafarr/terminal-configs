return {
    {
        "kyazdani42/nvim-tree.lua",
        cmd = { "NvimTreeToggle" },
        lazy = false,
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
        },
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            local icons = require("config.icons")
            local nvim_tree = require("nvim-tree")
            local nvim_tree_config = require("nvim-tree.config")

            local tree_cb = nvim_tree_config.nvim_tree_callback

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
                            default = icons.ui.DefaultFile,
                            symlink = icons.ui.FileSymlink,
                            folder = {
                                arrow_open = icons.ui.TriangleMiniArrowDown,
                                arrow_closed = icons.ui.TriangleMiniArrowRight,
                                default = icons.ui.Folder,
                                open = icons.ui.FolderOpen,
                                empty = icons.ui.EmptyFolder,
                                empty_open = icons.ui.EmptyFolderOpen,
                                symlink = icons.ui.FolderSymlink,
                                symlink_open = icons.ui.FolderSymlink,
                            },
                            git = {
                                unstaged = icons.git.Unstaged,
                                staged = icons.git.Staged,
                                unmerged = icons.git.Unmerged,
                                renamed = icons.git.Renamed,
                                untracked = icons.ui.SmallStar,
                                deleted = icons.git.Deleted,
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
        end,
    },
}
