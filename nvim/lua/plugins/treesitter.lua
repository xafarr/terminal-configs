return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "RRethy/nvim-treesitter-endwise",
            "windwp/nvim-ts-autotag",
            { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
        },
        config = function()
            local install = require("nvim-treesitter.install")

            local configs = require("nvim-treesitter.configs")

            install.update({ with_sync = true })

            configs.setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "c_sharp",
                    "cmake",
                    "cpp",
                    "css",
                    "dockerfile",
                    "git_config",
                    "git_rebase",
                    "gitattributes",
                    "gitcommit",
                    "gitignore",
                    "go",
                    "gomod",
                    "gosum",
                    "gowork",
                    "graphql",
                    "groovy",
                    "hcl",
                    "html",
                    "htmldjango",
                    "http",
                    "ini",
                    "java",
                    "javascript",
                    "jq",
                    "jsdoc",
                    "json",
                    "json5",
                    "jsonc",
                    "jsonnet",
                    "kotlin",
                    "llvm",
                    "lua",
                    "luadoc",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "mermaid",
                    "org",
                    "perl",
                    "php",
                    "puppet",
                    "python",
                    "python",
                    "regex",
                    "ruby",
                    "rust",
                    "scala",
                    "scss",
                    "sql",
                    "swift",
                    "terraform",
                    "toml",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "vue",
                    "yaml",
                },
                ignore_install = {}, -- List of parsers to ignore installing
                auto_install = true, -- Install language parsers automatically
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
                highlight = {
                    enable = true, -- false will disable the whole extension
                    disable = {}, -- list of language that will be disabled
                    additional_vim_regex_highlighting = { "org", "markdown" },
                },
                autopairs = {
                    enable = true,
                },
                matchup = {
                    enable = true,
                },
                endwise = {
                    enable = true,
                },
                autotag = {
                    enable = true,
                },
                indent = { enable = true, disable = { "yaml", "python" } },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<c-space>",
                        node_incremental = "<c-space>",
                        scope_incremental = "<c-s>",
                        node_decremental = "<M-space>",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                        },
                    },
                },
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = "o",
                        toggle_hl_groups = "i",
                        toggle_injected_languages = "t",
                        toggle_anonymous_nodes = "a",
                        toggle_language_display = "I",
                        focus_language = "f",
                        unfocus_language = "F",
                        update = "R",
                        goto_node = "<cr>",
                        show_help = "?",
                    },
                },
            })
        end,
    },
}
