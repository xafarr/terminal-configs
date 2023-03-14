return {
  {
    "lukas-reineke/indent-blankline.nvim", -- indentation guides to all lines
    dependencies = {},
    lazy = false,
    config = function()
      local blankline = require("indent_blankline")

      blankline.setup({
        show_current_context = true,
        show_current_context_start = true,
        show_end_of_line = true,
        space_char_blankline = " ",
        indent_blankline_use_treesitter = true,
      })
    end,
  },
}