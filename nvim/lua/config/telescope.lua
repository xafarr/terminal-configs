local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    layout_config = {
      preview_width = 80,
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}
