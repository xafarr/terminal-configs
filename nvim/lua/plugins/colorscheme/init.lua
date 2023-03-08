return {
  "kyazdani42/nvim-web-devicons", -- icons support
  {
    "sainnhe/edge",
    lazy = false,
    priority = 1000,
    config = function()
      require("plugins.colorscheme.edge") -- Edge colorscheme
      -- Colorscheme
      vim.cmd("colorscheme edge")
    end
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      local nightfox = require("nightfox")
      nightfox.setup({
        dim_inactive = true,
        options = {
          styles = {
            comments = "italic",
            keywords = "bold",
            functions = "italic",
          },
          inverse = {
            search = true,
            match_paren = true,
          },
          modules = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            telescope = true,
          },
        },
      })
    end
  },
  {
    "projekt0n/github-nvim-theme",
    config = function()
      local github = require("github-theme")

      github.setup({
        colors = {},
        comment_style = "italic",
        dark_float = false,
        dark_sidebar = true,
        dev = false,
        function_style = "NONE",
        hide_end_of_buffer = true,
        hide_inactive_statusline = true,
        keyword_style = "italic",
        msg_area_style = "NONE",
        overrides = function()
          return {}
        end,
        sidebars = {},
        theme_style = "light",
        transparent = false,
        variable_style = "NONE",
      })
    end
  },
}
