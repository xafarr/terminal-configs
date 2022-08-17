local nvim_tree = require("nvim-tree")
local nvim_tree_config = require("nvim-tree.config")

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
  remove_keymaps = { "<Tab>" },
  create_in_closed_folder = true,
  open_on_setup = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  git = {
    ignore = false
  },
  renderer = {
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
    height = 30,
    side = "left",
    mappings = {
      list = {
        { key = { "<CR>" }, cb = tree_cb "edit"  },
        { key = "<C-v>", cb = tree_cb "vsplit"  },
      },
    },
  },
}
