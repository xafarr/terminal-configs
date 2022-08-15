local status_ok, install = pcall(require, "nvim-treesitter.install")
if not status_ok then
	return
end

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

install.update({ with_sync = true })

configs.setup({
	ensure_installed = "all", -- one of "all" or a list of languages
	ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = {}, -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
	},
	autopairs = {
		enable = true,
	},
	indent = { 
    enable = true,
  },
})

