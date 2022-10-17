vim.cmd([[
    function! s:edge_custom() abort
      " Link a highlight group to a predefined highlight group.
      " See `colors/edge.vim` for all predefined highlight groups.
      "highlight! link illuminatedWord CurrentWord
      "highlight! link IlluminatedWordText CurrentWord
      "highlight! link IlluminatedWordRead CurrentWord
      "highlight! link IlluminatedWordWrite CurrentWord 
      " Initialize the color palette.
      " The first parameter is a valid value for `g:edge_style`,
      " the second parameter is a valid value for `g:edge_dim_foreground`,
      " and the third parameter is a valid value for `g:edge_colors_override`.
      let l:palette = edge#get_palette('', 0, {})
      " Define a highlight group.
      " The first parameter is the name of a highlight group,
      " the second parameter is the foreground color,
      " the third parameter is the background color,
      " the fourth parameter is for UI highlighting which is optional,
      " and the last parameter is for `guisp` which is also optional.
      " See `autoload/edge.vim` for the format of `l:palette`.
      call edge#highlight('Green', ['#067d17', '107'], l:palette.none)
      call edge#highlight('Field', ['#871094', '68'], l:palette.none)
      call edge#highlight('FieldItalic', ['#871094', '68'], l:palette.none, 'italic')
      call edge#highlight('Constant', ['#871094', '68'], l:palette.none, 'italic')
      call edge#highlight('Annotation', ['#9E880D', '134'], l:palette.none)
      call edge#highlight('Method', ['#00627A', '68'], l:palette.none)
      call edge#highlight('Number', ['#1750EB', '68'], l:palette.none)
      call edge#highlight('Keyword', ['#0033B3', '134'], l:palette.none)
      call edge#highlight('Attribute', ['#174AD4', '172'], l:palette.none)
      call edge#highlight('Comment', ['#8C8C8C', '172'], l:palette.none, 'italic')
      call edge#highlight('CurrentWord', l:palette.none, ['#e5e5ff', '253'])
      call edge#highlight('Visual', l:palette.none, ['#A6D2FF', '253'])
      call edge#highlight('VisualNOS', l:palette.none, ['#A6D2FF', '253'], 'underline')
      call edge#highlight('NvimTreeNormal', l:palette.none, ['#f3f4f4', '253'])
      call edge#highlight('GitSignsCurrentLineBlame', l:palette.grey_dim, l:palette.none)
      call edge#highlight('CursorLine', l:palette.none, ['#f3f5f7', '255'])
      call edge#highlight('Folded', l:palette.grey, ['#e9f5e6', 'NONE'])
      call edge#highlight('Todo', ['#008dde', '167'], l:palette.none, 'italic')
      call edge#highlight('StringEscape', ['#0037A6', '172'], l:palette.none)
      call edge#highlight('StringRegex', l:palette.none, ['#EDFCED', '172'])
      call edge#highlight('Black', ['#000000', '240'], l:palette.none)
      call edge#highlight('Link', ['#4585BE', '167'], l:palette.none)

      call edge#highlight('TSStrong', l:palette.none, l:palette.none, 'bold')
      call edge#highlight('TSEmphasis', l:palette.none, l:palette.none, 'italic')
      call edge#highlight('TSUnderline', l:palette.none, l:palette.none, 'underline')
      call edge#highlight('TSNote', l:palette.bg0, l:palette.blue, 'bold')
      call edge#highlight('TSWarning', l:palette.bg0, ['#F5EAC1', '172'], 'bold')
      call edge#highlight('TSDanger', l:palette.bg0, l:palette.red, 'bold')
      highlight! link TSAnnotation Annotation
      highlight! link TSAttribute Attribute
      highlight! link TSBoolean Green
      highlight! link TSCharacter Green
      highlight! link TSComment Comment
      highlight! link TSConditional Purple
      highlight! link TSConstBuiltin Constant
      highlight! link TSConstMacro Constant
      highlight! link TSConstant Constant
      highlight! link TSConstructor Blue
      highlight! link TSException Purple
      highlight! link TSField Field
      highlight! link TSFloat Number
      highlight! link TSFuncBuiltin Method
      highlight! link TSFuncMacro Method
      highlight! link TSFunction Method
      highlight! link TSInclude Purple
      highlight! link TSKeyword Keyword
      highlight! link TSKeywordFunction Keyword
      highlight! link TSKeywordOperator Keyword
      highlight! link TSLabel Purple
      highlight! link TSMethod Method 
      highlight! link TSNamespace Field
      highlight! link TSNone Fg
      highlight! link TSNumber Number
      highlight! link TSOperator Purple
      highlight! link TSParameter Black
      highlight! link TSParameterReference Black
      highlight! link TSProperty Field
      highlight! link TSPunctBracket Grey
      highlight! link TSPunctDelimiter Grey
      highlight! link TSPunctSpecial Yellow
      highlight! link TSRepeat Purple
      highlight! link TSStorageClass Purple
      highlight! link TSString Green
      highlight! link TSStringEscape StringEscape
      highlight! link TSStringRegex StringRegex
      highlight! link TSSymbol Attribute 
      highlight! link TSTag Keyword
      highlight! link TSTagAttribute Attribute
      highlight! link TSTagDelimiter Purple
      highlight! link TSText Green
      highlight! link TSStrike Grey
      highlight! link TSMath Green
      highlight! link TSTodo Todo
      highlight! link TSType Black
      highlight! link TSTypeBuiltin Keyword
      highlight! link TSURI Link
      highlight! link TSVariable Black
      highlight! link TSVariableBuiltin FieldItalic
      if has('nvim-0.8.0')
        highlight! link @annotation TSAnnotation
        highlight! link @attribute TSAttribute
        highlight! link @boolean TSBoolean
        highlight! link @character TSCharacter
        highlight! link @comment TSComment
        highlight! link @conditional TSConditional
        highlight! link @constant TSConstant
        highlight! link @constant.builtin TSConstBuiltin
        highlight! link @constant.macro TSConstMacro
        highlight! link @constructor TSConstructor
        highlight! link @exception TSException
        highlight! link @field TSField
        highlight! link @float TSFloat
        highlight! link @function TSFunction
        highlight! link @function.builtin TSFuncBuiltin
        highlight! link @function.macro TSFuncMacro
        highlight! link @include TSInclude
        highlight! link @keyword TSKeyword
        highlight! link @keyword.function TSKeywordFunction
        highlight! link @keyword.operator TSKeywordOperator
        highlight! link @label TSLabel
        highlight! link @method TSMethod
        highlight! link @namespace TSNamespace
        highlight! link @none TSNone
        highlight! link @number TSNumber
        highlight! link @operator TSOperator
        highlight! link @parameter TSParameter
        highlight! link @parameter.reference TSParameterReference
        highlight! link @property TSProperty
        highlight! link @punctuation.bracket TSPunctBracket
        highlight! link @punctuation.delimiter TSPunctDelimiter
        highlight! link @punctuation.special TSPunctSpecial
        highlight! link @repeat TSRepeat
        highlight! link @storageclass TSStorageClass
        highlight! link @string TSString
        highlight! link @string.escape TSStringEscape
        highlight! link @string.regex TSStringRegex
        highlight! link @symbol TSSymbol
        highlight! link @tag TSTag
        highlight! link @tag.delimiter TSTagDelimiter
        highlight! link @text TSText
        highlight! link @strike TSStrike
        highlight! link @math TSMath
        highlight! link @todo TSTodo
        highlight! link @type TSType
        highlight! link @type.builtin TSTypeBuiltin
        highlight! link @uri TSURI
        highlight! link @variable TSVariable
        highlight! link @variable.builtin TSVariableBuiltin
      endif
    endfunction
    
    augroup EdgeCustom
      autocmd!
      autocmd ColorScheme edge call s:edge_custom()
    augroup END

    let g:edge_better_performance = 1
    let g:edge_colors_override = {'bg0': ['#ffffff', '234'], 'fg0': ['#000000', '240']}
]])
