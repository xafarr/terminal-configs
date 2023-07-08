return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets", -- Collection of snippet
            "windwp/nvim-autopairs",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local icons = require("config.icons")
            local compare = require("cmp.config.compare")
            local cmp_window = require("cmp.config.window")

            -- Load collection of snippets from plugin "rafamadriz/friendly-snippets"
            require("luasnip.loaders.from_vscode").lazy_load()

            local check_backspace = function()
                local col = vim.fn.col(".") - 1
                return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
            end

            local has_words_before = function()
                if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
                    return false
                end
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
            end

            cmp.setup({
                completion = {
                    autocomplete = false,
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        require("copilot_cmp.comparators").prioritize,
                        -- Below is the default comparitor list and order for nvim-cmp
                        compare.offset,
                        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                        compare.exact,
                        compare.score,
                        compare.recently_used,
                        compare.locality,
                        compare.kind,
                        compare.sort_text,
                        compare.length,
                        compare.order,
                    },
                },
                mapping = {
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ["<Esc>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    -- Accept currently selected item. If none selected, `select` first item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        elseif luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif check_backspace() then
                            fallback()
                        else
                            fallback()
                        end
                    end),
                    ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end),
                },
                formatting = {
                    fields = { "abbr", "kind" },
                    format = function(entry, item)
                        local max_width = 0
                        local source_names = {
                            copilot = "(Copilot)",
                            nvim_lsp = "(LSP)",
                            luasnip = "(Snippet)",
                            buffer = "(Buffer)",
                            nvim_lua = "(Vim)",
                            path = "(Path)",
                        }
                        local duplicates = {
                            buffer = 1,
                            path = 1,
                            nvim_lsp = 0,
                            luasnip = 1,
                        }
                        local duplicates_default = 0
                        if max_width ~= 0 and #item.abbr > max_width then
                            item.abbr = string.sub(item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
                        end
                        item.kind = string.format(" %s  %s", icons.kind[item.kind], item.kind) -- This concatonates the icons with the name of the item kind
                        return item
                    end,
                },
                sources = {
                    { name = "copilot" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "nvim_lua" },
                    { name = "path" },
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                window = {
                    completion = cmp_window.bordered(),
                    documentation = cmp_window.bordered(),
                },
                experimental = {
                    ghost_text = false, -- this feature conflict with copilot.vim's preview.
                },
            })

            -- Auto pairs
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
        end,
    },
}
