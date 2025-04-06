local M = {}
local catppuccin_utils = require("catppuccin.utils.colors")

function M.get_custom_highlights(colors)
  return {
    NonText = { fg = catppuccin_utils.lighten(colors.surface0, 0.8) },
    GhostText = { fg = colors.surface1 },
  }
end

function M.get_latte_highlight_overrides(latte)
  local field_fg = catppuccin_utils.darken(latte.pink, 0.65)
  local keyword_fg = catppuccin_utils.darken(latte.blue, 0.8)
  local constant_style = { fg = field_fg, style = { "italic" } }
  local function_fg = catppuccin_utils.darken(latte.teal, 0.75)
  local attribute_fg = "#9E880D"
  return {
    CursorLine = { bg = catppuccin_utils.lighten(latte.blue, 0.07) },
    CursorLineNr = { bg = catppuccin_utils.lighten(latte.blue, 0.07) },
    CursorLineSign = { bg = catppuccin_utils.lighten(latte.blue, 0.07) },
    NvimTreeNormal = { bg = catppuccin_utils.lighten(latte.mantle, 0.4) },
    -- Vim Syntax
    Normal = { fg = latte.text },
    Identifier = { fg = field_fg },
    Keyword = { fg = keyword_fg },
    Number = { fg = latte.blue },
    Function = { fg = function_fg },
    Conditional = { fg = keyword_fg },
    Character = { fg = latte.green },
    Constant = constant_style,
    String = { fg = latte.green },
    Boolean = { fg = keyword_fg },
    -- Treesitter
    ["@boolean"] = { fg = keyword_fg },
    ["@number"] = { fg = latte.blue },
    ["@number.float"] = { fg = latte.blue },
    ["@annotation"] = { fg = attribute_fg },
    -- Keyword
    ["@keyword.coroutine"] = { fg = keyword_fg },
    ["@keyword.function"] = { fg = keyword_fg },
    ["@keyword.operator"] = { fg = keyword_fg },
    ["@keyword.import"] = { fg = keyword_fg },
    ["@keyword.type"] = { fg = keyword_fg },
    ["@keyword.modifier"] = { fg = keyword_fg },
    ["@keyword.repeat"] = { fg = keyword_fg },
    ["@keyword.return"] = { fg = keyword_fg },
    ["@keyword.debug"] = { fg = keyword_fg },
    ["@keyword.exception"] = { fg = keyword_fg },
    ["@keyword.conditional"] = { fg = keyword_fg },
    ["@keyword.conditional.ternary"] = { fg = keyword_fg },
    ["@keyword.directive"] = { fg = keyword_fg },
    ["@keyword.directive.define"] = { fg = keyword_fg },
    -- Function/Method
    ["@function"] = { fg = function_fg, style = { "italic" } },
    ["@function.call"] = { fg = function_fg, style = { "italic" } },
    ["@function.builtin"] = { fg = function_fg, style = { "italic" } },
    ["@function.macro"] = { fg = function_fg, style = { "italic" } },
    ["@function.method"] = { fg = function_fg },
    ["@function.method.call"] = { fg = function_fg },
    -- Variables/Constants
    ["@constant"] = constant_style,
    ["@constant.builtin"] = constant_style,
    ["@constant.macro"] = constant_style,
    ["@variable"] = { fg = latte.text },
    ["@variable.builtin"] = { fg = keyword_fg },
    ["@variable.parameter"] = { fg = latte.text },
    ["@variable.parameter.builtin"] = { fg = keyword_fg },
    ["@variable.member"] = { fg = field_fg },
    ["@field"] = { fg = field_fg },
    -- Types/Modules
    ["@type"] = { fg = latte.text },
    ["@type.builtin"] = { fg = keyword_fg },
    ["@type.definition"] = { fg = latte.text },
    ["@module"] = { fg = latte.text },
    ["@odule.builtin"] = { fg = keyword_fg },
    -- Comment
    ["@comment.error"] = { fg = latte.red, bg = latte.base, style = { "italic" } },
    ["@comment.warning"] = { fg = latte.yellow, bg = latte.base, style = { "italic" } },
    ["@comment.todo"] = { fg = latte.sky, bg = latte.base, style = { "italic" } },
    ["@comment.note"] = { fg = latte.sky, bg = latte.base, style = { "italic" } },
    -- Property
    ["@property"] = { fg = field_fg },
    ["@attribute"] = { fg = attribute_fg },
    ["@attribute.builtin"] = { fg = attribute_fg },
    -- Punctuation
    ["@punctuation.bracket"] = { fg = latte.text },
    ["@punctuation.delimiter"] = { fg = latte.text },
    ["@punctuation.special"] = { fg = latte.text },
    ["@operator"] = { fg = latte.text },
    -- Constructor
    ["@constructor"] = { fg = latte.text },
    ["@parameter"] = { fg = latte.text },
    -- String
    ["@string.regexp"] = { fg = latte.text, bg = catppuccin_utils.lighten(latte.green, 0.07) },
    ["@string.regex"] = { fg = latte.text, bg = catppuccin_utils.lighten(latte.green, 0.07) },
    ["@string.escape"] = { fg = catppuccin_utils.darken(latte.blue, 0.7) },
  }
end

return M
