local nightfox = require("nightfox")

nightfox.setup({
  dim_inactive = true,
  options = {
    styles = {
      comments = "italic",
      keywords = "bold",
      functions = "italic,bold",
    },
    inverse = {
      search = true,
      match_paren = true,
    },
  },
})

-- Colorscheme
vim.cmd("colorscheme nordfox")
