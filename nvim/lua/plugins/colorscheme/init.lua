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
}
