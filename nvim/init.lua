-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- For checkhealth warning
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

require("config.options")
require("config.neoconfigs")
require("utils.neoutils")
require("utils.colorutils")

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  once = true,
  callback = function()
    require("config.autocmds")
    require("config.keymaps")
  end,
})

require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.lsp" },
  },
  defaults = { lazy = true },
  install = {
    missing = true,
    colorscheme = { neoconfigs.lazy.default_to_current_colorscheme and neoconfigs.UI.colorscheme },
  },
  checker = { enabled = true, notify = false },
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
if neoconfigs.UI.colors_override.enabled then
  local colors_override_config = "config.colorscheme.override" .. neoconfigs.UI.colorscheme
  local ok, _ = pcall(require, colors_override_config)
  if not ok then
    error(string.format('Colors override config "%s" does not exist', colors_override_config))
  end
end

-- Set the colorscheme according to config
vim.cmd("colorscheme " .. neoconfigs.UI.colorscheme)
