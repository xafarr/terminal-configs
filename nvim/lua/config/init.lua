local M = {}

M.uname = vim.loop.os_uname()
M.OS = M.uname.sysname

M.lazy = {
    defaults = {
        lazy = true,
    },
    default_to_current_colorscheme = true,
}

function M.IS_WINDOWS()
    return M.OS:find("Windows") and true or false
end

function M.IS_MAC()
    return M.OS == "Darwin"
end

function M.IS_LINUX()
    return M.OS == "Linux"
end

function M.IS_WSL()
    return M.IS_LINUX() and M.uname.release:find("Microsoft") and true or false
end

function M.NvimTreeWidth(percentage)
    local ratio = percentage / 100
    local width = vim.go.columns
    if width < 150 then
        return math.floor(vim.go.columns * ratio)
    elseif width < 200 then
        ratio = (percentage - 5) / 100
        return math.floor(vim.go.columns * ratio)
    else
        ratio = (percentage - 10) / 100
        return math.floor(vim.go.columns * ratio)
    end
end

M.UI = {
    colorscheme = "tokyonight-storm",
    colors_override = {
        enabled = false,
    },
}

M.languages = {
    lua = {
        enable = true,
        treesitter = {
            base = true,
            luadoc = false,
            patterns = true,
        },
        LSP = {
            enable = true,
            neodev = {
                enable = true,
                opts = {
                    library = {
                        plugins = false,
                    },
                },
            },
        },
        DAP = {
            enabled = true,
        },
    },
    svelte = {
        enable = true,
        treesitter = {
            base = true,
            javascript = true,
            typescript = true,
            rust = false,
            css = true,
        },
        LSP = {
            enable = true,
            servers = {
                svelte = {},
                emmet_ls = {},
                tailwindcss = {},
            },
            typescript = {
                -- This requires the Typescript intregation!
                enable = true,
            },
        },
        DAP = {
            enable = true,
        },
    },
    typescript = {
        enable = false,
        tools = {
            enable = true,
        },
    },
    markdown = {
        enable = true,
        treesitter = {
            markdown = true,
            markdown_inline = true,
            additional_parsers = {},
        },
        LSP = {
            enable = true,
            providers = {
                marksman = {},
                -- You can add more servers as you please.
                prosemd_lsp = {},
                -- mdformat = {},
            },
        },
    },
    python = {
        enable = false,
        treesitter = {
            base = true,
            ninja = false,
            rst = false,
            toml = false,
        },
        LSP = {
            config = {
                enable = true,
                servers = {
                    pyright = {},
                    ruff_lsp = {},
                },
            },
            null = {
                enable = true,
                servers = {
                    black = {},
                },
            },
        },
        semshi = {
            enable = true,
        },
    },
    toml = {
        enable = false,
        LSP = {
            null = {
                enable = true,
            },
            config = {
                enable = true,
                servers = {
                    taplo = {},
                },
            },
        },
    },
    rust = {
        enable = false,
        LSP = {
            config = {
                enable = true,
            },
        },
    },
    go = {
        enable = false,
        LSP = {
            config = {
                enable = true,
                servers = {
                    gopls = {},
                },
            },
            null = {
                enable = true,
                sources = {
                    gofumpt = {},
                    goimports_reviser = {},
                    golines = {},
                },
            },
        },
    },
    html = {
        enable = false,
        LSP = {
            config = {
                enable = true,
                servers = {
                    html = {},
                },
            },
        },
    },
}

M.LSP = {
    enabled = true,
    config = {
        opts = {
            servers_to_not_setup = {},
            servers = {},
            setup = {},
        },
    },
    on_attach = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint(bufnr, true)
                end
            end,
        })
    end,
}

M.coding = {
    enabled = true,
    cmp = {
        sources = {
            { name = "emoji", source = "hrsh7th/cmp-emoji", priority = 99999 },
            { name = "luasnip", source = "saadparwaiz1/cmp_luasnip" },
            { name = "nvim_lsp", source = "hrsh7th/cmp-nvim-lsp" },
            { name = "buffer", source = "hrsh7th/cmp-buffer" },
            { name = "path", source = "hrsh7th/cmp-path" },
        },
        cmd = {
            enabled = true,
        },
        ghost_text = true,
        snippet = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    autotag = {
        ft = {
            "svelte",
            "html",
        },
    },
}

M.editor = {
    enabled = true,
    nvimtree = {
        width = 30, -- pecentage wrt neovim window
    },
    treesitter = {
        parsers = {},
    },
}

M.tools = {
    enabled = true,
}

M.DAP = {
    enabled = true,
}

_G.neoconfig = M
