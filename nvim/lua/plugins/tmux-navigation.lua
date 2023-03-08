return {
  {
    "alexghergh/nvim-tmux-navigation",
    lazy = false,
    config = function()
      local tmux_navigation = require("nvim-tmux-navigation")
      tmux_navigation.setup({
        keybindings = {
          left = "<M-Left>",
          down = "<M-Down>",
          up = "<M-Up>",
          right = "<M-Right>",
          last_active = "<C-def>",
          next = "<C-abc>",
        },
      })
    end
  }
}
