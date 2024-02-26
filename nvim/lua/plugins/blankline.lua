return {
  {
    "lukas-reineke/indent-blankline.nvim", -- indentation guides to all lines
    event = "VeryLazy",
    dependencies = {},
    main = "ibl",
    config = function()
      local blankline = require("ibl")
      local icons = require("config.icons")

      blankline.setup({
        scope = {
          enabled = true,
          show_start = true,
          show_end = false,
          include = {
            node_type = { ["*"] = { "*" } },
          },
        },
        indent = {
          char = icons.ui.LineLeft,
        },
        whitespace = {
          remove_blankline_trail = false,
        },
        exclude = {
          filetypes = {
            "NvimTree",
            "TelescopePrompt",
            "TelescopeResults",
            "Trouble",
            "alpha",
            "dashboard",
            "gitcommit",
            "help",
            "lazy",
            "man",
            "mason",
            "notify",
            "toggleterm",
            "trouble",
            "lspinfo",
            "checkhealth",
          },
          buftypes = {},
        },
      })
    end,
  },
}
