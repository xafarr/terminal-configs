local telescope = require("telescope")
local actions = require("telescope.actions")
local neoclip = require("neoclip")
local trouble = require("trouble.providers.telescope")

neoclip.setup({
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

telescope.setup({
    defaults = {
        prompt_prefix = " ", -- 🔍
        selection_caret = " ",
        path_display = { "smart" },
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            preview_width = 0.7,
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
        mappings = {
            i = {
                ["<Esc>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<C-e>"] = actions.results_scrolling_down,
                ["<C-y>"] = actions.results_scrolling_up,
                ["<C-v]"] = actions.select_vertical,
                ["<C-x]"] = actions.select_horizontal,
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-t>"] = trouble.open_with_trouble,
            },
            n = {
                ["<C-t>"] = trouble.open_with_trouble,
            },
        },
    },
    pickers = {
        find_files = {
            find_command = {
                "rg",
                "--files",
                "--hidden",
                "--glob",
                "!.git/*",
                "--glob",
                "!node_modules/*",
                "--glob",
                "!target/*",
            },
            hidden = true,
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
    },
})

telescope.load_extension("fzf")
telescope.load_extension("neoclip")
telescope.load_extension("macroscope")
