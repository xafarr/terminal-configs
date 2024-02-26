return {
  {
    "alexghergh/nvim-tmux-navigation",
    lazy = false,
    config = function()
      local tmux_navigation = require("nvim-tmux-navigation")
      tmux_navigation.setup({
        keybindings = {
          left = "<C-Left>",
          down = "<C-Down>",
          up = "<C-Up>",
          right = "<C-Right>",
          --last_active = "<C-def>",
          --next = "<C-abc>",
        },
      })
    end,
  },
}
