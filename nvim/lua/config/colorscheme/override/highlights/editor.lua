local M = {}
local set_hl = neoutils.set_hl

function M.override_highlight(palette)
  -- Colors
  set_hl("Green", { fg = palette.green, bg = palette.none })
  set_hl("Yellow", { fg = palette.yellow, bg = palette.none })

  set_hl("NonText", { fg = colorutils.lighten(palette.black, 0.8) })
  set_hl("GhostText", { fg = colorutils.lighten(palette.black, 0.7) })
  set_hl("Conceal", { link = "GhostText" })

  -- Visual
  local visual_bg = colorutils.lighten(palette.blue, 0.7)
  set_hl("Search", { fg = palette.none, bg = visual_bg, bold = true })
  set_hl("Visual", { fg = palette.none, bg = visual_bg, bold = true })
  set_hl("VisualNOS", { fg = palette.none, bg = visual_bg, underline = true })

  set_hl("IncSearch", { fg = palette.none, bg = colorutils.lighten(palette.blue, 0.8) })

  -- CursorLine
  local cursorline_bg = colorutils.lighten(palette.blue, 0.95)
  set_hl("CursorLine", { fg = palette.none, bg = cursorline_bg })
  set_hl("CursorLineNr", { link = "CursorLine" })
  set_hl("CursorLineSign", { link = "CursorLine" })

  set_hl("Folded", { fg = palette.grey, bg = colorutils.lighten(palette.green, 0.9) })
  set_hl("Todo", { fg = palette.blue, bg = palette.none, bold = true, italic = true })
  set_hl("StringEscape", { fg = colorutils.darken(palette.blue, 0.3), bg = palette.none })
  set_hl("StringRegex", { fg = palette.none, bg = colorutils.lighten(palette.green, 0.8) })
  set_hl("Black", { fg = palette.black, bg = palette.none })
  set_hl("BlackItalic", { fg = palette.black, bg = palette.none, italic = true })
  set_hl("Link", { fg = colorutils.darken(palette.blue, 0.5), bg = palette.none, italic = true, underline = true })
  set_hl("Label", { fg = palette.blue, bg = palette.none })

  set_hl("TSStrong", { fg = palette.none, bg = palette.none, bold = true })
  set_hl("TSEmphasis", { fg = palette.none, bg = palette.none, italic = true })
  set_hl("TSUnderline", { fg = palette.none, bg = palette.none, underline = true })

  -- Diagnostics
  local warning_hl = colorutils.lighten(palette.yellow, 0.8)
  local error_hl = colorutils.lighten(palette.red, 0.8)
  local todo_hl = colorutils.lighten(palette.cyan, 0.8)
  local hint_hl = colorutils.lighten(palette.blue, 0.8)
  set_hl("TSWarning", { fg = palette.none, bg = warning_hl, bold = true })
  set_hl("TSDanger", { fg = palette.none, bg = error_hl, bold = true })
  set_hl("TSTodo", { fg = palette.none, bg = todo_hl, italic = true })
  set_hl("TSNote", { fg = palette.blue, bg = palette.base, bold = true, italic = true })
  set_hl("TSHint", { fg = palette.none, bg = hint_hl, bold = true })

  -- NvimTree and Window container
  local window_hl = colorutils.lighten(palette.grey, 0.9)
  --('SignColumn',{fg =  palette.none, bg = dim_grey })
  --('LineNr',{fg =  palette.grey, bg = dim_grey })
  set_hl("NvimTreeGitIgnored", { link = "Conceal" })
  set_hl("VertSplit", { fg = window_hl, bg = window_hl })
  set_hl("NvimTreeNormal", { bg = window_hl })
  set_hl("NvimTreeWinSeperator", { bg = window_hl })
  set_hl("NvimTreeCursorLineInactive", { bg = colorutils.lighten(palette.grey, 0.7) })
  set_hl("NvimTreeCursorLineActive", { bg = colorutils.lighten(palette.blue, 0.85) })
  set_hl("NvimTreeCursorLine", { link = "NvimTreeCursorLineInactive" })
  set_hl("NvimTreeCursorLineNr", { link = "NvimTreeCursorLine" })
  set_hl("NvimTreeGitNewIcon", { fg = palette.green, bg = palette.none })

  -- Indent Blankline v2
  local indentchar_hl = colorutils.lighten(palette.grey, 0.8)
  set_hl("IndentChar", { fg = indentchar_hl, bg = palette.none })
  set_hl("IndentContextChar", { fg = palette.grey, bg = palette.none, bold = true })
  set_hl("IndentContextStart", { fg = palette.none, bg = palette.none, underline = true })
  set_hl("IndentBlanklineChar", { link = "IndentChar" })
  set_hl("IndentBlanklineContextChar", { link = "IndentContextChar" })
  set_hl("IndentBlanklineContextStart", { link = "IndentContextStart" })

  -- Indent Blankline v3
  set_hl("IblIndent", { link = "IndentBlanklineChar" })
  set_hl("IblWhitespace", { link = "IndentBlanklineChar" })
  set_hl("IblScope", { link = "IndentBlanklineContextChar" })

  -- Gitsigns
  set_hl("GreenSign", { fg = colorutils.lighten(palette.green, 0.8), bg = palette.none })
  set_hl("BlueSign", { fg = colorutils.lighten(palette.blue, 0.8), bg = palette.none })
  set_hl("RedSign", { fg = colorutils.lighten(palette.red, 0.8), bg = palette.none })
  set_hl("YellowSign", { fg = colorutils.lighten(palette.yellow, 0.8), bg = palette.none })
  set_hl("GitSignsAdd", { link = "GreenSign" })
  set_hl("GitSignsChange", { link = "BlueSign" })
  set_hl("GitSignsDelete", { link = "RedSign" })
  set_hl("GitSignsAddNr", { link = "GreenSign" })
  set_hl("GitSignsChangeNr", { link = "BlueSign" })
  set_hl("GitSignsDeleteNr", { link = "RedSign" })
  set_hl("GitSignsAddLn", { link = "DiffAdd" })
  set_hl("GitSignsChangeLn", { link = "DiffChange" })
  set_hl("GitSignsDeleteLn", { link = "DiffDelete" })
  set_hl("GitSignsCurrentLineBlame", { link = "Conceal" })

  -- Illuminate
  set_hl("CurrentWord", { fg = palette.none, bg = colorutils.lighten(palette.lavender, 0.8) })
  set_hl("IlluminatedCurWord", { link = "CurrentWord" })
  set_hl("IlluminatedWordRead", { link = "CurrentWord" })
  set_hl("IlluminatedWordWrite", { link = "CurrentWord" })
  set_hl("IlluminatedWordText", { link = "CurrentWord" })
end

return M
