local M = {}

local _, highlights = pcall(require, "config.colorscheme.override.highlights")

local palette = {
  base = "#ffffff",
  black = "#2d2f3f",
  blue = "#008DDE",
  crust = "#dce0e8",
  cyan = "#00627A",
  fg = "#2d2f3f",
  flamingo = "#dd7878",
  green = "#067D17",
  grey = "#8C8C8C",
  lavender = "#7287fd",
  mantle = "#e6e9ef",
  maroon = "#e64553",
  mauve = "#8839ef",
  none = "NONE",
  peach = "#efa498",
  pink = "#ea76cb",
  purple = "#871094",
  red = "#d05858",
  rosewater = "#dc8a78",
  sapphire = "#209fb5",
  sky = "#04a5e5",
  text = "#2d2f3f",
  yellow = "#be7e05",
}

function M.override_highlight()
  if vim.o.background == "light" then
    vim.g.edge_colors_override = {
      black = palette.black,
      bg0 = palette.base,
      grey = palette.grey,
      fg = palette.fg,
      purple = palette.purple,
      none = palette.none,
    }

    highlights.override_highlight(palette)
  end
end

return M
