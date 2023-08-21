-- init.lua
vim.loader.enable()

require("config")
require("config.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
        { import = "plugins.lsp" },
    },
    defaults = { lazy = true },
    install = {
        missing = true,
        colorscheme = { neoconfig.lazy.default_to_current_colorscheme and neoconfig.UI.colorscheme },
    },
    checker = { enabled = true },
    change_detection = {
        notify = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    -- debug = true,
})

-- Override colors of colorscheme if enabled and available
if neoconfig.UI.colors_override then
    local colors_override_config = "config.colorscheme." .. neoconfig.UI.colorscheme
    local ok, _ = pcall(require, colors_override_config)
    if not ok then
        error(string.format('Colors override config "%s" does not exist', colors_override_config))
    end
end

-- Set the colorscheme according to config
vim.cmd("colorscheme " .. neoconfig.UI.colorscheme)

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("config.keymaps")
        require("config.autocmds")
    end,
})
