local M = {}
local flavour = require("catppuccin").options.background[vim.o.background]
local palette = require("catppuccin.palettes").get_palette(flavour)
local _, highlights = pcall(require, "config.colorscheme.override.highlights")

function M.override_highlight()
  if flavour == "latte" then
    palette.black = palette.text
    highlights.override_highlight(palette)
  end
end

return M
