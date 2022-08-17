local blankline = require("indent_blankline")

blankline.setup {
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true,
  use_treesitter_scope = true,
}
