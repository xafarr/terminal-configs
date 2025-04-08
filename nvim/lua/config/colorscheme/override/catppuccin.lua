local M = {}
local flavour = require("catppuccin").options.background.light
local palette = require("catppuccin.palettes").get_palette(flavour)
local _, highlights = pcall(require, "config.colorscheme.override.highlights")

function M.override_highlight()
  if vim.o.background == "light" then
    palette.black = palette.text
    highlights.override_highlight(palette)
  end
end

return M
