-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Automatically install lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
require("lazy").setup({
    -- My plugins here
    -- General plugins
    "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
    "windwp/nvim-autopairs", -- Autopairs, integrated with both cmp and treesitter
    "kyazdani42/nvim-web-devicons", -- icons support
    "lukas-reineke/indent-blankline.nvim", -- indentation guides to all lines

    -- Code commenting plugins
    "numToStr/Comment.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",

    -- Colorschemes
    "EdenEast/nightfox.nvim",
    "sainnhe/edge",
    "projekt0n/github-nvim-theme",

    -- Treesitter for code highlight
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            pcall(require("nvim-treesitter.install").update({ with_sync = true }))
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
    },
    "nvim-treesitter/playground",

    -- Status line
    "nvim-lualine/lualine.nvim",
    "akinsho/bufferline.nvim",

    -- File Explorer
    "kyazdani42/nvim-tree.lua",

    -- Fuzzy finder
    "nvim-telescope/telescope.nvim",
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
            return vim.fn.executable("make") == 1
        end,
    },
    "AckslD/nvim-neoclip.lua",

    -- Nvim LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require("fidget").setup({})`
            { "j-hui/fidget.nvim", opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            "folke/neodev.nvim",
        },
    },

    "jose-elias-alvarez/null-ls.nvim",
    "RRethy/vim-illuminate",
    "folke/trouble.nvim",
    "brenoprata10/nvim-highlight-colors",
    "mfussenegger/nvim-dap",

    -- Code autocompletion plugins
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets", -- Collection of snippet
        },
    },

    -- Terminal
    { "akinsho/toggleterm.nvim", version = "*" },

    -- Neovim tmux navigation
    "alexghergh/nvim-tmux-navigation",

    -- Git
    "lewis6991/gitsigns.nvim",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",

    -- Org Mode (Like Emac's org mode,
    "nvim-orgmode/orgmode",

    -- Github Copilot
    "github/copilot.vim",
})
