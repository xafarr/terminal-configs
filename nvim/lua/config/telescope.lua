local telescope = require("telescope")
local actions = require("telescope.actions")
local neoclip = require("neoclip")

neoclip.setup {
  default_register = { "+", "*" },
  keys = {
    telescope = {
      i = {
        select = '<cr>',
        paste = '<c-p>',
        paste_behind = '<c-P>',
        replay = '<c-q>', -- replay a macro
        delete = '<c-d>', -- delete an entry
        custom = {},
      },
      n = {
        select = '<cr>',
        paste = 'p',
        --- It is possible to map to more than one key.
        -- paste = { 'p', '<c-p>' },
        paste_behind = 'P',
        replay = 'q',
        delete = 'd',
        custom = {},
      },
    },
  }
}

telescope.setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    layout_config = {
      preview_width = 80,
      scroll_speed = 5,
    },
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<C-v]"] = actions.select_vertical,
        ["<C-x]"] = actions.select_horizontal,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    neoclip = {},
  }
}

telescope.load_extension("fzf")
telescope.load_extension("neoclip")
telescope.load_extension("macroscope")

