local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    -- General plugins
    use("wbthomason/packer.nvim") -- Have packer manage itself
    use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins
    use("windwp/nvim-autopairs") -- Autopairs, integrated with both cmp and treesitter
    use("kyazdani42/nvim-web-devicons") -- icons support
    use("lukas-reineke/indent-blankline.nvim") -- indentation guides to all lines
    use("numToStr/Comment.nvim")

    -- Colorschemes
    use("lifepillar/vim-gruvbox8")
    use("EdenEast/nightfox.nvim")

    -- Treesitter for code highlight
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    -- Status line
    use("nvim-lualine/lualine.nvim")

    -- File Explorer
    use("kyazdani42/nvim-tree.lua")

    -- Fuzzy finder
    use("nvim-telescope/telescope.nvim")
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use("AckslD/nvim-neoclip.lua")

    -- Nvim LSP
    use("williamboman/nvim-lsp-installer")
    use("neovim/nvim-lspconfig")
    use("jose-elias-alvarez/null-ls.nvim")
    use("RRethy/vim-illuminate")

    -- Code autocompletion plugins
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lua")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("rafamadriz/friendly-snippets") -- Collection of snippet

    -- Terminal
    use("akinsho/toggleterm.nvim")

    -- Git
    use("lewis6991/gitsigns.nvim")
end)
