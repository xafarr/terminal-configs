local M = {}

local palette = {
  black = "#2d2f3f",
  bg_dim = "#e8ebf0",
  bg0 = "#ffffff",
  bg1 = "#fafafa",
  bg2 = "#eef1f4",
  bg3 = "#e8ebf0",
  bg4 = "#dde2e7",
  bg_grey = "#bcc5cf",
  bg_red = "#e17373",
  diff_red = "#f6e4e4",
  bg_green = "#50A45C",
  diff_green = "#EDFCED",
  bg_blue = "#4CAFE7",
  diff_blue = "#C3D6E8",
  bg_purple = "#AB57B4",
  diff_yellow = "#f0ece2",
  fg = "#2d2f3f",
  red = "#d05858",
  yellow = "#be7e05",
  green = "#067D17",
  cyan = "#00627A",
  blue = "#008DDE",
  purple = "#871094",
  grey = "#8C8C8C",
  grey_dim = "#C5C5C5",
  none = "NONE",
}

function M.override_highlight()
  local set_hl = function(group, color)
    vim.api.nvim_set_hl(0, group, color)
  end

  set_hl("Search", { fg = palette.none, bg = palette.diff_blue })
  set_hl("IncSearch", { fg = palette.none, bg = palette.diff_green })

  set_hl("Green", { fg = palette.green, bg = palette.none })
  set_hl("Field", { fg = palette.purple, bg = palette.none })
  set_hl("FieldItalic", { fg = palette.purple, bg = palette.none, italic = true })
  set_hl("Constant", { fg = palette.purple, bg = palette.none, italic = true })
  set_hl("Annotation", { fg = "#9E880D", bg = palette.none })
  set_hl("Method", { fg = palette.cyan, bg = palette.none })
  set_hl("MethodItalic", { fg = palette.cyan, bg = palette.none, italic = true })
  set_hl("Function", { fg = palette.purple, bg = palette.none })
  set_hl("FuncItalic", { fg = palette.purple, bg = palette.none, italic = true })
  set_hl("Number", { fg = "#1750EB", bg = palette.none })
  set_hl("Keyword", { fg = "#0033B3", bg = palette.none })
  set_hl("Attribute", { fg = "#174AD4", bg = palette.none })
  set_hl("Comment", { fg = palette.grey, bg = palette.none, italic = true })
  set_hl("PreProc", { fg = palette.grey, bg = palette.none, bold = true, italic = true })
  set_hl("CurrentWord", { fg = palette.none, bg = "#e5e5ff" })
  set_hl("Visual", { fg = palette.none, bg = "#A6D2FF" })
  set_hl("VisualNOS", { fg = palette.none, bg = "#A6D2FF", underline = true })
  --('SignColumn',{fg =  palette.none, bg = ['#f3f4f4', '253'] })
  set_hl("VertSplit", { fg = "#f3f4f4", bg = "#f3f4f4" })
  --('LineNr',{fg =  palette.grey, bg = ['#f3f4f4', '253'] })
  set_hl("CursorLine", { fg = palette.none, bg = "#fcfaed" })
  set_hl("CursorLineNr", { fg = palette.none, bg = "#fcfaed" })
  set_hl("CursorLineSign", { fg = palette.none, bg = "#fcfaed" })
  set_hl("Folded", { fg = palette.grey, bg = "#e9f5e6" })
  set_hl("Todo", { fg = palette.blue, bg = palette.none, bold = true, italic = true })
  set_hl("StringEscape", { fg = "#0037A6", bg = palette.none })
  set_hl("StringRegex", { fg = palette.none, bg = palette.diff_green })
  set_hl("Black", { fg = palette.black, bg = palette.none })
  set_hl("BlackItalic", { fg = palette.black, bg = palette.none, italic = true })
  set_hl("Link", { fg = "#4585BE", bg = palette.none })
  set_hl("Label", { fg = "#4A86E8", bg = palette.none })
  set_hl("IndentChar", { fg = "#e6e6e6", bg = palette.none })
  set_hl("IndentContextChar", { fg = palette.grey, bg = palette.none, bold = true })
  set_hl("IndentContextStart", { fg = palette.none, bg = palette.none, underline = true })
  set_hl("GreenSign", { fg = "#C9DEC1", bg = palette.none })
  set_hl("BlueSign", { fg = palette.diff_blue, bg = palette.none })
  set_hl("RedSign", { fg = palette.red, bg = palette.none })
  set_hl("YellowSign", { fg = palette.yellow, bg = palette.none })

  set_hl("TSStrong", { fg = palette.none, bg = palette.none, bold = true })
  set_hl("TSEmphasis", { fg = palette.none, bg = palette.none, italic = true })
  set_hl("TSUnderline", { fg = palette.none, bg = palette.none, underline = true })
  set_hl("TSNote", { fg = palette.blue, bg = palette.bg0, bold = true, italic = true })
  set_hl("TSWarning", { fg = palette.none, bg = "#F5EAC1", bold = true })
  set_hl("TSDanger", { fg = palette.none, bg = palette.red, bold = true })

  -- Link Highlight

  -- NvimTree
  set_hl("NvimTreeGitIgnored", { link = "Conceal" })
  set_hl("NvimTreeNormal", { bg = "#f3f4f4" })
  set_hl("NvimTreeWinSeperator", { bg = "#f3f4f4" })

  -- Indent Blankline v2
  set_hl("IndentBlanklineChar", { link = "IndentChar" })
  set_hl("IndentBlanklineContextChar", { link = "IndentContextChar" })
  set_hl("IndentBlanklineContextStart", { link = "IndentContextStart" })

  -- Indent Blankline v3
  set_hl("IblIndent", { link = "IndentBlanklineChar" })
  set_hl("IblWhitespace", { link = "IndentBlanklineChar" })
  set_hl("IblScope", { link = "IndentBlanklineContextChar" })

  -- Gitsigns
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

  -- XML highlight
  set_hl("xmlTag", { link = "Black" })
  set_hl("xmlEndTag", { link = "Black" })
  set_hl("xmlTagName", { link = "Keyword" })
  set_hl("xmlEqual", { link = "Black" })
  set_hl("xmlAttrib", { link = "Attribute" })
  set_hl("xmlEntity", { link = "Keyword" })
  set_hl("xmlEntityPunct", { link = "Field" })
  set_hl("xmlDocTypeDecl", { link = "Comment" })
  set_hl("xmlDocTypeKeyword", { link = "FieldItalic" })
  set_hl("xmlCdataStart", { link = "Comment" })
  set_hl("xmlCdataCdata", { link = "Yellow" })
  set_hl("xmlString", { link = "Green" })
  set_hl("xmlProcessingDelim", { link = "BlackItalic" })

  -- Code Syntax
  set_hl("@annotation", { link = "Annotation" })
  set_hl("@attribute", { link = "Attribute" })
  set_hl("@boolean", { link = "Keyword" })
  set_hl("@character", { link = "Green" })
  set_hl("@character.special", { link = "SpecialChar" })
  set_hl("@comment", { link = "Comment" })
  set_hl("@conceal", { link = "Grey" })
  set_hl("@conditional", { link = "Keyword" })
  set_hl("@constant", { link = "Constant" })
  set_hl("@constant.builtin", { link = "Constant" })
  set_hl("@constant.macro", { link = "Constant" })
  set_hl("@constructor", { link = "Black" })
  set_hl("@debug", { link = "Debug" })
  set_hl("@define", { link = "Define" })
  set_hl("@error", { link = "Error" })
  set_hl("@exception", { link = "Keyword" })
  set_hl("@field", { link = "Field" })
  set_hl("@float", { link = "Float" })
  set_hl("@function", { link = "Function" })
  set_hl("@function.builtin", { link = "Keyword" })
  set_hl("@function.call", { link = "FuncItalic" })
  set_hl("@function.macro", { link = "FuncItalic" })
  set_hl("@include", { link = "Keyword" })
  set_hl("@keyword", { link = "Keyword" })
  set_hl("@keyword.function", { link = "Keyword" })
  set_hl("@keyword.operator", { link = "Keyword" })
  set_hl("@keyword.modifier", { link = "Keyword" })
  set_hl("@keyword.return", { link = "Keyword" })
  set_hl("@label", { link = "Label" })
  set_hl("@math", { link = "Green" })
  set_hl("@method", { link = "Method" })
  set_hl("@method.call", { link = "MethodItalic" })
  set_hl("@namespace", { link = "Keyword" })
  set_hl("@none", { link = "Fg" })
  set_hl("@number", { link = "Number" })
  set_hl("@operator", { link = "Black" })
  set_hl("@parameter", { link = "Black" })
  set_hl("@parameter.reference", { link = "Field" })
  set_hl("@preproc", { link = "PreProc" })
  set_hl("@property", { link = "Black" })
  set_hl("@punctuation.bracket", { link = "Black" })
  set_hl("@punctuation.delimiter", { link = "Black" })
  set_hl("@punctuation.special", { link = "Black" })
  set_hl("@repeat", { link = "Keyword" })
  set_hl("@storageclass", { link = "Purple" })
  set_hl("@storageclass.lifetime", { link = "Purple" })
  set_hl("@strike", { link = "Grey" })
  set_hl("@string", { link = "Green" })
  set_hl("@string.escape", { link = "StringEscape" })
  set_hl("@string.regex", { link = "StringRegex" })
  set_hl("@string.special", { link = "SpecialChar" })
  set_hl("@symbol", { link = "Attribute" })
  set_hl("@tag", { link = "Keyword" })
  set_hl("@tag.attribute", { link = "Attribute" })
  set_hl("@tag.delimiter", { link = "Black" })
  set_hl("@text", { link = "Green" })
  set_hl("@text.danger", { link = "TSDanger" })
  set_hl("@text.diff.add", { link = "diffAdded" })
  set_hl("@text.diff.delete", { link = "diffRemoved" })
  set_hl("@text.emphasis", { link = "TSEmphasis" })
  set_hl("@text.environment", { link = "Macro" })
  set_hl("@text.environment.name", { link = "Type" })
  set_hl("@text.literal", { link = "String" })
  set_hl("@text.math", { link = "Green" })
  set_hl("@text.note", { link = "TSNote" })
  set_hl("@text.reference", { link = "Constant" })
  set_hl("@text.strike", { link = "Grey" })
  set_hl("@text.strong", { link = "TSStrong" })
  set_hl("@text.title", { link = "Title" })
  set_hl("@text.todo", { link = "Todo" })
  set_hl("@text.todo.checked", { link = "Green" })
  set_hl("@text.todo.unchecked", { link = "Ignore" })
  set_hl("@text.underline", { link = "TSUnderline" })
  set_hl("@text.uri", { link = "Link" })
  set_hl("@text.warning", { link = "TSWarning" })
  set_hl("@todo", { link = "Todo" })
  set_hl("@type", { link = "Black" })
  set_hl("@type.builtin", { link = "Keyword" })
  set_hl("@type.definition", { link = "Black" })
  set_hl("@type.qualifier", { link = "Purple" })
  set_hl("@uri", { link = "Link" })
  set_hl("@variable", { link = "Black" })
  set_hl("@variable.builtin", { link = "Keyword" })

  set_hl("@lsp.type.class", { link = "Black" })
  set_hl("@lsp.type.comment", { link = "Comment" })
  set_hl("@lsp.type.decorator", { link = "Function" })
  set_hl("@lsp.type.enum", { link = "Black" })
  set_hl("@lsp.type.enumMember", { link = "Field" })
  set_hl("@lsp.type.events", { link = "Label" })
  set_hl("@lsp.type.function", { link = "Function" })
  set_hl("@lsp.type.interface", { link = "Black" })
  set_hl("@lsp.type.keyword", { link = "Keyword" })
  set_hl("@lsp.type.macro", { link = "Constant" })
  set_hl("@lsp.type.method", { link = "Method" })
  set_hl("@lsp.type.modifier", { link = "Purple" })
  set_hl("@lsp.type.namespace", { link = "Keyword" })
  set_hl("@lsp.type.number", { link = "Number" })
  set_hl("@lsp.type.operator", { link = "Black" })
  set_hl("@lsp.type.parameter", { link = "Black" })
  set_hl("@lsp.type.property", { link = "Field" })
  set_hl("@lsp.type.regexp", { link = "StringRegex" })
  set_hl("@lsp.type.string", { link = "Green" })
  set_hl("@lsp.type.struct", { link = "Black" })
  set_hl("@lsp.type.type", { link = "Black" })
  set_hl("@lsp.type.typeParameter", { link = "Black" })
  set_hl("@lsp.type.variable", { link = "Black" })
  set_hl("DiagnosticUnnecessary", { link = "TSWarning" })
  set_hl("TSModuleInfoGood", { link = "Green" })
  set_hl("TSModuleInfoBad", { link = "Red" })
end

return M
