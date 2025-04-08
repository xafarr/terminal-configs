local M = {}
local _, editor = pcall(require, "config.colorscheme.override.highlights.editor")
local _, treesitter = pcall(require, "config.colorscheme.override.highlights.treesitter")
local black = "#2D2F3F"

function M.override_highlight(palette)
  local _palette = {
    base = palette.base or "#FFFFFF",
    black = palette.black or black,
    blue = palette.blue or "#008DDE",
    crust = palette.crust or "#DCE0E8",
    cyan = palette.cyan or palette.teal or "#00627A",
    fg = palette.fg or black,
    flamingo = palette.flamingo or "#DD7878",
    green = palette.green or "#067D17",
    grey = palette.grey or "#8C8C8C",
    lavender = palette.lavender or "#7287FD",
    mantle = palette.mantle or "#E6E9EF",
    maroon = palette.maroon or "#E64553",
    mauve = palette.mauve or "#8839EF",
    none = palette.none or "NONE",
    peach = palette.peach or "#eFA498",
    pink = palette.pink or "#EA76CB",
    purple = palette.purple or "#871094",
    red = palette.red or "#D05858",
    rosewater = palette.rosewater or "#DC8A78",
    sapphire = palette.sapphire or "#209FB5",
    sky = palette.sky or "#04A5E5",
    text = palette.text or black,
    yellow = palette.yellow or "#BE7E05",
  }

  editor.override_highlight(_palette)
  treesitter.override_highlight(_palette)
end

return M
