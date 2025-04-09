local M = {}
local set_hl = neoutils.set_hl

function M.override_highlight(palette)
  set_hl("Field", { fg = palette.purple, bg = palette.none })
  set_hl("FieldItalic", { fg = palette.purple, bg = palette.none, italic = true })
  set_hl("Constant", { fg = palette.purple, bg = palette.none, italic = true })
  set_hl("Annotation", { fg = colorutils.blend(palette.yellow, palette.green, 0.25), bg = palette.none })
  set_hl("Method", { fg = palette.cyan, bg = palette.none })
  set_hl("MethodItalic", { fg = palette.cyan, bg = palette.none, italic = true })
  set_hl("Function", { fg = palette.purple, bg = palette.none })
  set_hl("FunctionItalic", { fg = palette.purple, bg = palette.none, italic = true })
  set_hl("Number", { fg = palette.blue, bg = palette.none })
  set_hl("Keyword", { fg = colorutils.darken(palette.blue, 0.4), bg = palette.none })
  set_hl("Attribute", { fg = colorutils.darken(palette.blue, 0.2), bg = palette.none })
  set_hl("Comment", { fg = palette.grey, bg = palette.none, italic = true })
  set_hl("PreProc", { fg = palette.grey, bg = palette.none, bold = true, italic = true })
  set_hl("Black", { fg = palette.black, bg = palette.none })
  set_hl("BlackItalic", { fg = palette.black, bg = palette.none, italic = true })
  set_hl("String", { fg = palette.green, bg = palette.none })
  set_hl("Operator", { link = "Attribute" })
  set_hl("Boolean", { link = "Keyword" })
  set_hl("Special", { fg = colorutils.darken(palette.maroon, 0.3), bg = palette.none })
  set_hl("Type", { fg = palette.text })

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

  -- Identifiers
  set_hl("@variable", { fg = palette.text })
  set_hl("@variable.parameter", { fg = palette.text })
  set_hl("@variable.builtin", { link = "Keyword" })
  set_hl("@variable.member", { link = "Field" })
  set_hl("@property", { link = "Field" })

  set_hl("@constant", { link = "Constant" })
  set_hl("@constant.builtin", { link = "Constant" })
  set_hl("@constant.macro", { link = "Constant" })

  set_hl("@module", { fg = palette.text, italic = true })
  set_hl("@module.builtin", { link = "Keyword", italic = true })
  set_hl("@label", { link = "Label" })

  -- Literals
  set_hl("@string", { link = "String" })
  set_hl("@string.documentation", { fg = palette.cyan })
  set_hl("@string.regexp", { link = "StringRegex" }) -- For regexes.
  set_hl("@string.escape", { link = "StringEscape" }) -- For escape characters within a string.
  set_hl("@string.special", { link = "Special" }) -- other special strings (e.g. dates)
  set_hl("@string.special.path", { link = "Special" }) -- filenames
  set_hl("@string.special.symbol", { fg = palette.flamingo }) -- symbols or atoms
  set_hl("@string.special.url", { link = "Link" }) -- urls, links and emails

  set_hl("@character", { link = "String" }) -- character literals
  set_hl("@character.special", { link = "Special" }) -- special characters (e.g. wildcards)

  set_hl("@boolean", { link = "Boolean" }) -- For booleans.
  set_hl("@number", { link = "Number" }) -- For all numbers
  set_hl("@number.float", { link = "Float" }) -- For floats.

  -- Types
  set_hl("@type", { link = "Type" }) -- For types.
  set_hl("@type.builtin", { fg = palette.text, italic = true }) -- For builtin types.
  set_hl("@type.definition", { link = "Type" }) -- type definitions (e.g. `typedef` in palette)
  set_hl("@type.qualifier", { link = "Type" })
  set_hl("@attribute", { link = "Attribute" }) -- attribute annotations (e.g. Python decorators)
  set_hl("@annotation", { link = "Annotation" })

  -- Functions
  set_hl("@function", { link = "Function" }) -- For function (calls and definitions).
  set_hl("@function.builtin", { link = "FunctionItalic" }) -- For builtin functions: table.insert in Lua.
  set_hl("@function.call", { link = "FunctionItalic" }) -- function calls
  set_hl("@function.macro", { link = "FunctionItalic" }) -- For macro defined functions (calls and definitions): each macro_rules in Rust.

  set_hl("@function.method", { link = "Method" }) -- For method definitions.
  set_hl("@function.method.call", { link = "MethodItalic" }) -- For method calls.

  set_hl("@constructor", { link = "Method" }) -- For constructor calls and definitions: = { } in Lua, and Java constructors.
  set_hl("@operator", { link = "Operator" }) -- For any operator: +, but also -> and * in palette.

  -- Keywords
  set_hl("@keyword", { link = "Keyword" }) -- For keywords that don't fall in previous categories.
  set_hl("@keyword.modifier", { link = "Keyword" }) -- For keywords modifying other constructs (e.g. `const`, `static`, `public`)
  set_hl("@keyword.type", { link = "Keyword" }) -- For keywords describing composite types (e.g. `struct`, `enum`)
  set_hl("@keyword.coroutine", { link = "Keyword" }) -- For keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
  set_hl("@keyword.function", { link = "Keyword" }) -- For keywords used to define a function.
  set_hl("@keyword.operator", { link = "Operator" }) -- For new keyword operator
  set_hl("@keyword.import", { link = "Keyword" }) -- For includes: #include in palette, use or extern crate in Rust, or require in Lua.
  set_hl("@keyword.repeat", { link = "Keyword" }) -- For keywords related to loops.
  set_hl("@keyword.return", { link = "Keyword" })
  set_hl("@keyword.debug", { link = "Keyword" }) -- For keywords related to debugging
  set_hl("@keyword.exception", { link = "Keyword" }) -- For exception related keywords.

  set_hl("@keyword.conditional", { fg = colorutils.darken(palette.blue, 0.3), italic = true }) -- For keywords related to conditionnals.
  set_hl("@keyword.conditional.ternary", { link = "Operator" }) -- For ternary operators (e.g. `?` / `:`)

  set_hl("@keyword.directive", { link = "PreProc" }) -- various preprocessor directives & shebangs
  set_hl("@keyword.directive.define", { link = "Define" })

  -- JS & derivative
  set_hl("@keyword.export", { link = "Keyword" })

  -- Punctuation
  local punctuation_hl = colorutils.darken(palette.cyan, 0.5)
  set_hl("@punctuation.delimiter", { fg = punctuation_hl })
  set_hl("@punctuation.bracket", { fg = punctuation_hl })
  set_hl("@punctuation.special", { fg = punctuation_hl })

  -- Comment
  set_hl("@comment", { link = "Comment" })
  set_hl("@comment.documentation", { link = "Comment" })

  set_hl("@comment.error", { fg = palette.base, bg = palette.red })
  set_hl("@comment.warning", { fg = palette.base, bg = palette.yellow })
  set_hl("@comment.hint", { fg = palette.base, bg = palette.blue })
  set_hl("@comment.todo", { fg = palette.base, bg = palette.flamingo })
  set_hl("@comment.note", { fg = palette.base, bg = palette.rosewater })

  -- Markup
  set_hl("@markup", { fg = palette.text })
  set_hl("@markup.strong", { fg = palette.maroon, bold = true })
  set_hl("@markup.italic", { fg = palette.maroon, italic = true })
  set_hl("@markup.strikethrough", { fg = palette.text, strikethrough = true })
  set_hl("@markup.underline", { link = "TSUnderline" })

  set_hl("@markup.heading", { fg = palette.blue, bold = true })

  set_hl("@markup.math", { fg = palette.blue })
  set_hl("@markup.quote", { fg = palette.maroon, bold = true })
  set_hl("@markup.environment", { fg = palette.pink })
  set_hl("@markup.environment.name", { fg = palette.blue })

  set_hl("@markup.link", { link = "Tag" })
  set_hl("@markup.link.label", { link = "Label" })
  set_hl("@markup.link.url", { fg = palette.rosewater, italic = true, underline = true })

  set_hl("@markup.raw", { fg = palette.teal })

  set_hl("@markup.list", { link = "Special" })
  set_hl("@markup.list.checked", { fg = palette.green })
  set_hl("@markup.list.unchecked", { fg = palette.overlay1 })

  -- Diff
  set_hl("@diff.plus", { link = "diffAdded" })
  set_hl("@diff.minus", { link = "diffRemoved" })
  set_hl("@diff.delta", { link = "diffChanged" })

  -- Tags
  set_hl("@tag", { link = "Keyword" })
  set_hl("@tag.builtin", { fg = colorutils.darken(palette.blue, 0.3), italic = true })
  set_hl("@tag.attribute", { link = "Attribute" })
  set_hl("@tag.delimiter", { fg = palette.black })

  -- Misc
  set_hl("@error", { link = "Error" })

  -- Language specific:
  -- bash
  set_hl("@function.builtin.bash", { link = "FunctionItalic" })

  -- markdown
  set_hl("@markup.heading.1.markdown", { link = "rainbow1" })
  set_hl("@markup.heading.2.markdown", { link = "rainbow2" })
  set_hl("@markup.heading.3.markdown", { link = "rainbow3" })
  set_hl("@markup.heading.4.markdown", { link = "rainbow4" })
  set_hl("@markup.heading.5.markdown", { link = "rainbow5" })
  set_hl("@markup.heading.6.markdown", { link = "rainbow6" })

  -- java
  set_hl("@constant.java", { link = "Constant" })
  set_hl("@attribute.java", { link = "Annotation" })

  -- css
  set_hl("@property.css", { fg = palette.lavender })
  set_hl("@property.id.css", { fg = palette.blue })
  set_hl("@property.class.css", { fg = palette.yellow })
  set_hl("@type.css", { fg = palette.lavender })
  set_hl("@type.tag.css", { fg = palette.mauve })
  set_hl("@string.plain.css", { fg = palette.peach })
  set_hl("@number.css", { fg = palette.peach })

  -- toml
  set_hl("@property.toml", { fg = palette.blue })

  -- json
  set_hl("@label.json", { fg = palette.blue })

  -- lua
  set_hl("@constructor.lua", { link = "@constructor" })

  -- typescript
  set_hl("@property.typescript", { link = "@property" })
  set_hl("@constructor.typescript", { link = "@constructor" })

  -- TSX (Typescript React)
  set_hl("@constructor.tsx", { link = "@constructor" })
  set_hl("@tag.attribute.tsx", { fg = colorutils.darken(palette.blue, 0.2), italic = true })

  -- yaml
  set_hl("@variable.member.yaml", { link = "Field" })

  -- Ruby
  set_hl("@string.special.symbol.ruby", { fg = palette.flamingo })

  -- PHP
  set_hl("@function.method.php", { link = "Method" })
  set_hl("@function.method.call.php", { link = "MethodItalic" })

  -- palette/CPP
  set_hl("@type.builtin.c", { fg = palette.yellow })
  set_hl("@property.cpp", { fg = palette.text })
  set_hl("@type.builtin.cpp", { fg = palette.yellow })

  -- gitcommit
  set_hl("@comment.warning.gitcommit", { fg = palette.yellow })

  -- gitignore
  set_hl("@string.special.path.gitignore", { fg = palette.text })

  -- Misc
  set_hl("gitcommitSummary", { fg = palette.rosewater, italic = true })
  set_hl("zshKSHFunction", { link = "Function" })

  -- Legacy highlights
  set_hl("@parameter", { link = "@variable.parameter" })
  set_hl("@field", { link = "@variable.member" })
  set_hl("@namespace", { link = "@module" })
  set_hl("@float", { link = "@number.float" })
  set_hl("@symbol", { link = "@string.special.symbol" })
  set_hl("@string.regex", { link = "@string.regexp" })

  set_hl("@text", { link = "@markup" })
  set_hl("@text.strong", { link = "@markup.strong" })
  set_hl("@text.emphasis", { link = "@markup.italic" })
  set_hl("@text.underline", { link = "@markup.underline" })
  set_hl("@text.strike", { link = "@markup.strikethrough" })
  set_hl("@text.uri", { link = "@markup.link.url" })
  set_hl("@text.math", { link = "@markup.math" })
  set_hl("@text.environment", { link = "@markup.environment" })
  set_hl("@text.environment.name", { link = "@markup.environment.name" })

  set_hl("@text.title", { link = "@markup.heading" })
  set_hl("@text.literal", { link = "@markup.raw" })
  set_hl("@text.reference", { link = "@markup.link" })

  set_hl("@text.todo.checked", { link = "@markup.list.checked" })
  set_hl("@text.todo.unchecked", { link = "@markup.list.unchecked" })

  set_hl("@comment.note", { link = "@comment.hint" })

  -- @text.todo is now for todo comments, not todo notes like in markdown
  set_hl("@text.todo", { link = "@comment.todo" })
  set_hl("@text.warning", { link = "@comment.warning" })
  set_hl("@text.note", { link = "@comment.note" })
  set_hl("@text.danger", { link = "@comment.error" })

  -- @text.uri is now
  -- > @markup.link.url in markup links
  -- > @string.special.url outside of markup
  set_hl("@text.uri", { link = "@markup.link.uri" })

  set_hl("@method", { link = "@function.method" })
  set_hl("@method.call", { link = "@function.method.call" })

  set_hl("@text.diff.add", { link = "@diff.plus" })
  set_hl("@text.diff.delete", { link = "@diff.minus" })

  set_hl("@type.qualifier", { link = "@keyword.modifier" })
  set_hl("@keyword.storage", { link = "@keyword.modifier" })
  set_hl("@define", { link = "@keyword.directive.define" })
  set_hl("@preproc", { link = "@keyword.directive" })
  set_hl("@storageclass", { link = "@keyword.storage" })
  set_hl("@conditional", { link = "@keyword.conditional" })
  set_hl("@exception", { link = "@keyword.exception" })
  set_hl("@include", { link = "@keyword.import" })
  set_hl("@repeat", { link = "@keyword.repeat" })

  set_hl("@symbol.ruby", { link = "@string.special.symbol.ruby" })

  set_hl("@variable.member.yaml", { link = "@field.yaml" })

  set_hl("@text.title.1.markdown", { link = "@markup.heading.1.markdown" })
  set_hl("@text.title.2.markdown", { link = "@markup.heading.2.markdown" })
  set_hl("@text.title.3.markdown", { link = "@markup.heading.3.markdown" })
  set_hl("@text.title.4.markdown", { link = "@markup.heading.4.markdown" })
  set_hl("@text.title.5.markdown", { link = "@markup.heading.5.markdown" })
  set_hl("@text.title.6.markdown", { link = "@markup.heading.6.markdown" })

  set_hl("@method.php", { link = "@function.method.php" })
  set_hl("@method.call.php", { link = "@function.method.call.php" })
end

return M
