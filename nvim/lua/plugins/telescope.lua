return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        cond = function()
          return vim.fn.executable("cmake") == 1
        end,
      },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "ahmedkhalf/project.nvim",
      "cljoly/telescope-repo.nvim",
      "stevearc/aerial.nvim",
      "kkharji/sqlite.lua",
      "aaronhallaert/advanced-git-search.nvim",
    },
    cmd = "Telescope",
    config = function(_, _)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local trouble = require("trouble.providers.telescope")
      local icons = require("config.icons")
      local actions_layout = require("telescope.actions.layout")

      local mappings = {
        i = {
          ["<Esc>"] = actions.close,
          ["<C-a>"] = actions.select_all,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,
          ["<C-e>"] = actions.results_scrolling_down,
          ["<C-y>"] = actions.results_scrolling_up,
          ["<C-v]"] = actions.select_vertical,
          ["<C-x]"] = actions.select_horizontal,
          ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["?"] = actions_layout.toggle_preview,
          ["<C-t>"] = trouble.open_with_trouble,
        },
        n = {
          ["<C-t>"] = trouble.open_with_trouble,
        },
      }

      local opts = {
        defaults = {
          prompt_prefix = icons.ui.Telescope .. " ",
          selection_caret = icons.ui.Forward .. " ",
          mappings = mappings,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          path_display = neoutils.filename_first,
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            preview_width = 0.65,
            scroll_speed = 5,
            prompt_position = "top",
          },
          file_ignore_patterns = { "^.git/", "^target/", "^node_modules/" },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
            "--glob",
            "!.git/*",
            "--glob",
            "!node_modules/*",
            "--glob",
            "!target/*",
          },
        },
        pickers = {
          find_files = {
            -- theme = "dropdown",
            -- previewer = false,
            hidden = true,
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "-g",
              "!.git/",
              "-g",
              "!node_modules/",
              "-g",
              "!target/",
            },
          },
          git_files = {
            --  theme = "dropdown",
            --previewer = false,
          },
          buffers = {
            ignore_current_buffer = true,
            -- sort_lastused = true,
            sort_mru = true,
          },
        },
        extensions = {
          file_browser = {
            --theme = "dropdown",
            -- previewer = false,
            hijack_netrw = true,
            mappings = mappings,
          },
          project = {
            hidden_files = false,
            -- theme = "dropdown",
          },
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      }

      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("project")
      telescope.load_extension("projects")
      telescope.load_extension("aerial")
      --      telescope.load_extension "dap"
      telescope.load_extension("advanced_git_search")
      telescope.load_extension("neoclip")
      telescope.load_extension("macroscope")
      telescope.load_extension("ui-select")
    end,
  },
  {
    "AckslD/nvim-neoclip.lua",
    lazy = false,
    config = function()
      require("neoclip").setup({
        default_register = { "+", "*" },
        keys = {
          telescope = {
            i = {
              select = "<cr>",
              paste = "<c-p>",
              paste_behind = "<c-P>",
              replay = "<c-q>", -- replay a macro
              delete = "<c-d>", -- delete an entry
              custom = {},
            },
            n = {
              select = "<cr>",
              paste = "p",
              --- It is possible to map to more than one key.
              -- paste = { 'p', '<c-p>' },
              paste_behind = "P",
              replay = "q",
              delete = "d",
              custom = {},
            },
          },
        },
      })
    end,
  },
}
