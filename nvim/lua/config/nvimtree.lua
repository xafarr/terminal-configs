local nvim_tree = require("nvim-tree")

nvim_tree.setup {
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
  }
}
