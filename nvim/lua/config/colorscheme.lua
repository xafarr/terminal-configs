--[[ local nightfox = require("nightfox") ]]

--[[ nightfox.setup({ ]]
--[[     dim_inactive = true, ]]
--[[     options = { ]]
--[[         styles = { ]]
--[[             comments = "italic", ]]
--[[             keywords = "bold", ]]
--[[             functions = "italic", ]]
--[[         }, ]]
--[[         inverse = { ]]
--[[             search = true, ]]
--[[             match_paren = true, ]]
--[[         }, ]]
--[[         modules = { ]]
--[[             cmp = true, ]]
--[[             gitsigns = true, ]]
--[[             nvimtree = true, ]]
--[[             treesitter = true, ]]
--[[             telescope = true, ]]
--[[         }, ]]
--[[     }, ]]
--[[ }) ]]

vim.g.edge_style = "aura"
vim.g.edge_colors_override = { bg3 = { "#A6D3F3", "237" } }

-- Colorscheme
vim.cmd("colorscheme edge")
