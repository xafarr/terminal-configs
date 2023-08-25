vim.cmd([[
    function! s:highlight_custom(group, fg, bg, ...)
      execute 'highlight' a:group
            \ 'guifg=' . a:fg[0]
            \ 'guibg=' . a:bg[0]
            \ 'ctermfg=' . a:fg[1]
            \ 'ctermbg=' . a:bg[1]
            \ 'gui=' . (a:0 >= 1 ?
              \ a:1 :
              \ 'NONE')
            \ 'cterm=' . (a:0 >= 1 ?
              \ a:1 :
              \ 'NONE')
            \ 'guisp=' . (a:0 >= 2 ?
              \ a:2[0] :
              \ 'NONE')
    endfunction

    function! s:edge_custom() abort
        call s:highlight_custom('Green', s:palette.green, s:palette.none)
        call s:highlight_custom('Field', s:palette.purple, s:palette.none)
        call s:highlight_custom('FieldItalic', s:palette.purple, s:palette.none, 'italic')
        call s:highlight_custom('Constant', s:palette.purple, s:palette.none, 'italic')
        call s:highlight_custom('Annotation', ['#9E880D', '134'], s:palette.none)
        call s:highlight_custom('Method', s:palette.cyan, s:palette.none)
        call s:highlight_custom('MethodItalic', s:palette.cyan, s:palette.none, 'italic')
        call s:highlight_custom('Function', s:palette.purple, s:palette.none)
        call s:highlight_custom('FuncItalic', s:palette.purple, s:palette.none, 'italic')
        call s:highlight_custom('Number', ['#1750EB', '68'], s:palette.none)
        call s:highlight_custom('Keyword', ['#0033B3', '134'], s:palette.none)
        call s:highlight_custom('Attribute', ['#174AD4', '172'], s:palette.none)
        call s:highlight_custom('Comment', s:palette.grey, s:palette.none, 'italic')
        call s:highlight_custom('PreProc', s:palette.grey, s:palette.none, 'bold,italic')
        call s:highlight_custom('CurrentWord', s:palette.none, ['#e5e5ff', '253'])
        call s:highlight_custom('Visual', s:palette.none, ['#A6D2FF', '253'])
        call s:highlight_custom('VisualNOS', s:palette.none, ['#A6D2FF', '253'], 'underline')
        "call s:highlight_custom('SignColumn', s:palette.none, ['#f3f4f4', '253'])
        call s:highlight_custom('VertSplit', ['#f3f4f4', '253'], ['#f3f4f4', '253'])
        "call s:highlight_custom('LineNr', s:palette.grey, ['#f3f4f4', '253'])
        call s:highlight_custom('CursorLine', s:palette.none, ['#fcfaed', '255'])
        call s:highlight_custom('CursorLineNr', s:palette.none, ['#fcfaed', '255'])
        call s:highlight_custom('CursorLineSign', s:palette.none, ['#fcfaed', '255'])
        call s:highlight_custom('Folded', s:palette.grey, ['#e9f5e6', '172'])
        call s:highlight_custom('Todo', s:palette.blue, s:palette.none, 'bold,italic')
        call s:highlight_custom('StringEscape', ['#0037A6', '172'], s:palette.none)
        call s:highlight_custom('StringRegex', s:palette.none, s:palette.diff_green)
        call s:highlight_custom('Black', s:palette.black, s:palette.none)
        call s:highlight_custom('BlackItalic', s:palette.black, s:palette.none, 'italic')
        call s:highlight_custom('Link', ['#4585BE', '167'], s:palette.none)
        call s:highlight_custom('Label', ['#4A86E8', '167'], s:palette.none)
        call s:highlight_custom('IndentChar', ['#e6e6e6', '240'], s:palette.none)
        call s:highlight_custom('IndentContextChar', s:palette.grey, s:palette.none)
        call s:highlight_custom('IndentContextStart', s:palette.none, s:palette.none, 'underline', s:palette.grey)
        call s:highlight_custom('GreenSign', ['#C9DEC1', '107'], s:palette.none)
        call s:highlight_custom('BlueSign', s:palette.diff_blue, s:palette.none)
        call s:highlight_custom('RedSign', s:palette.red, s:palette.none)
        call s:highlight_custom('YellowSign', s:palette.yellow, s:palette.none)

        call s:highlight_custom('TSStrong', s:palette.none, s:palette.none, 'bold')
        call s:highlight_custom('TSEmphasis', s:palette.none, s:palette.none, 'italic')
        call s:highlight_custom('TSUnderline', s:palette.none, s:palette.none, 'underline')
        call s:highlight_custom('TSNote', s:palette.blue, s:palette.bg0, 'bold,italic')
        call s:highlight_custom('TSWarning', s:palette.none, ['#F5EAC1', '172'], 'bold')
        call s:highlight_custom('TSDanger', s:palette.none, s:palette.red, 'bold')

        " NvimTree
        highlight! link NvimTreeGitIgnored Conceal
        highlight! NvimTreeNormal guibg=#f3f4f4
        highlight! NvimTreeWinSeperator guibg=#f3f4f4

        " Indent Blankline
        highlight! link IndentBlanklineChar IndentChar
        highlight! link IndentBlanklineContextChar IndentContextChar
        highlight! link IndentBlanklineContextStart IndentContextStart

        " Gitsigns
        highlight! link GitSignsAdd GreenSign
        highlight! link GitSignsChange BlueSign
        highlight! link GitSignsDelete RedSign
        highlight! link GitSignsAddNr GreenSign
        highlight! link GitSignsChangeNr BlueSign
        highlight! link GitSignsDeleteNr RedSign
        highlight! link GitSignsAddLn DiffAdd
        highlight! link GitSignsChangeLn DiffChange
        highlight! link GitSignsDeleteLn DiffDelete
        highlight! link GitSignsCurrentLineBlame Conceal

        " XML highlight
        highlight! link xmlTag Black
        highlight! link xmlEndTag Black
        highlight! link xmlTagName Keyword
        highlight! link xmlEqual Black
        highlight! link xmlAttrib Attribute
        highlight! link xmlEntity Keyword
        highlight! link xmlEntityPunct Field
        highlight! link xmlDocTypeDecl Comment
        highlight! link xmlDocTypeKeyword FieldItalic
        highlight! link xmlCdataStart Comment
        highlight! link xmlCdataCdata Yellow
        highlight! link xmlString Green
        highlight! link xmlProcessingDelim BlackItalic

        highlight! link TSAnnotation Annotation
        highlight! link TSAttribute Attribute
        highlight! link TSBoolean Keyword
        highlight! link TSCharacter Green
        highlight! link TSCharacterSpecial SpecialChar
        highlight! link TSComment Comment
        highlight! link TSConditional Keyword
        highlight! link TSConstBuiltin Constant
        highlight! link TSConstMacro Constant
        highlight! link TSConstant Constant
        highlight! link TSConstructor Black
        highlight! link TSDebug Debug
        highlight! link TSDefine Define
        highlight! link TSEnvironment Macro
        highlight! link TSEnvironmentName Type
        highlight! link TSError Error
        highlight! link TSException Keyword
        highlight! link TSField Field
        highlight! link TSFloat Number
        highlight! link TSFuncBuiltin Keyword
        highlight! link TSFuncMacro FuncItalic
        highlight! link TSFunction Function
        highlight! link TSFunctionCall FuncItalic
        highlight! link TSInclude Keyword
        highlight! link TSKeyword Keyword
        highlight! link TSKeywordFunction Keyword
        highlight! link TSKeywordOperator Keyword
        highlight! link TSKeywordReturn Keyword
        highlight! link TSLabel Label
        highlight! link TSLiteral String
        highlight! link TSMath Green
        highlight! link TSMethod Method
        highlight! link TSMethodCall MethodItalic
        highlight! link TSNamespace Keyword
        highlight! link TSNone Fg
        highlight! link TSNumber Number
        highlight! link TSOperator Black
        highlight! link TSParameter Black
        highlight! link TSParameterReference Field
        highlight! link TSPreProc PreProc
        highlight! link TSProperty Field
        highlight! link TSPunctBracket Black
        highlight! link TSPunctDelimiter Black
        highlight! link TSPunctSpecial Black
        highlight! link TSRepeat Keyword
        highlight! link TSStorageClass Purple
        highlight! link TSStorageClassLifetime Purple
        highlight! link TSStrike Grey
        highlight! link TSString Green
        highlight! link TSStringEscape StringEscape
        highlight! link TSStringRegex StringRegex
        highlight! link TSStringSpecial SpecialChar
        highlight! link TSSymbol Attribute
        highlight! link TSTag Keyword
        highlight! link TSTagAttribute Attribute
        highlight! link TSTagDelimiter Black
        highlight! link TSText Green
        highlight! link TSTextReference Constant
        highlight! link TSTitle Title
        highlight! link TSTodo Todo
        highlight! link TSType Black
        highlight! link TSTypeBuiltin Keyword
        highlight! link TSTypeDefinition Black
        highlight! link TSTypeQualifier Purple
        highlight! link TSURI Link
        highlight! link TSVariable Black
        highlight! link TSVariableBuiltin Keyword
        if has('nvim-0.8.0')
          highlight! link @annotation TSAnnotation
          highlight! link @attribute TSAttribute
          highlight! link @boolean TSBoolean
          highlight! link @character TSCharacter
          highlight! link @character.special TSCharacterSpecial
          highlight! link @comment TSComment
          highlight! link @conceal Grey
          highlight! link @conditional TSConditional
          highlight! link @constant TSConstant
          highlight! link @constant.builtin TSConstBuiltin
          highlight! link @constant.macro TSConstMacro
          highlight! link @constructor TSConstructor
          highlight! link @debug TSDebug
          highlight! link @define TSDefine
          highlight! link @error TSError
          highlight! link @exception TSException
          highlight! link @field TSField
          highlight! link @float TSFloat
          highlight! link @function TSFunction
          highlight! link @function.builtin TSFuncBuiltin
          highlight! link @function.call TSFunctionCall
          highlight! link @function.macro TSFuncMacro
          highlight! link @include TSInclude
          highlight! link @keyword TSKeyword
          highlight! link @keyword.function TSKeywordFunction
          highlight! link @keyword.operator TSKeywordOperator
          highlight! link @keyword.return TSKeywordReturn
          highlight! link @label TSLabel
          highlight! link @math TSMath
          highlight! link @method TSMethod
          highlight! link @method.call TSMethodCall
          highlight! link @namespace TSNamespace
          highlight! link @none TSNone
          highlight! link @number TSNumber
          highlight! link @operator TSOperator
          highlight! link @parameter TSParameter
          highlight! link @parameter.reference TSParameterReference
          highlight! link @preproc TSPreProc
          highlight! link @property TSProperty
          highlight! link @punctuation.bracket TSPunctBracket
          highlight! link @punctuation.delimiter TSPunctDelimiter
          highlight! link @punctuation.special TSPunctSpecial
          highlight! link @repeat TSRepeat
          highlight! link @storageclass TSStorageClass
          highlight! link @storageclass.lifetime TSStorageClassLifetime
          highlight! link @strike TSStrike
          highlight! link @string TSString
          highlight! link @string.escape TSStringEscape
          highlight! link @string.regex TSStringRegex
          highlight! link @string.special TSStringSpecial
          highlight! link @symbol TSSymbol
          highlight! link @tag TSTag
          highlight! link @tag.attribute TSTagAttribute
          highlight! link @tag.delimiter TSTagDelimiter
          highlight! link @text TSText
          highlight! link @text.danger TSDanger
          highlight! link @text.diff.add diffAdded
          highlight! link @text.diff.delete diffRemoved
          highlight! link @text.emphasis TSEmphasis
          highlight! link @text.environment TSEnvironment
          highlight! link @text.environment.name TSEnvironmentName
          highlight! link @text.literal TSLiteral
          highlight! link @text.math TSMath
          highlight! link @text.note TSNote
          highlight! link @text.reference TSTextReference
          highlight! link @text.strike TSStrike
          highlight! link @text.strong TSStrong
          highlight! link @text.title TSTitle
          highlight! link @text.todo TSTodo
          highlight! link @text.todo.checked Green
          highlight! link @text.todo.unchecked Ignore
          highlight! link @text.underline TSUnderline
          highlight! link @text.uri TSURI
          highlight! link @text.warning TSWarning
          highlight! link @todo TSTodo
          highlight! link @type TSType
          highlight! link @type.builtin TSTypeBuiltin
          highlight! link @type.definition TSTypeDefinition
          highlight! link @type.qualifier TSTypeQualifier
          highlight! link @uri TSURI
          highlight! link @variable TSVariable
          highlight! link @variable.builtin TSVariableBuiltin
        endif
        if has('nvim-0.9.0')
          highlight! link @lsp.type.class TSType
          highlight! link @lsp.type.comment TSComment
          highlight! link @lsp.type.decorator TSFunction
          highlight! link @lsp.type.enum TSType
          highlight! link @lsp.type.enumMember TSProperty
          highlight! link @lsp.type.events TSLabel
          highlight! link @lsp.type.function TSFunction
          highlight! link @lsp.type.interface TSType
          highlight! link @lsp.type.keyword TSKeyword
          highlight! link @lsp.type.macro TSConstMacro
          highlight! link @lsp.type.method TSMethod
          highlight! link @lsp.type.modifier TSTypeQualifier
          highlight! link @lsp.type.namespace TSNamespace
          highlight! link @lsp.type.number TSNumber
          highlight! link @lsp.type.operator TSOperator
          highlight! link @lsp.type.parameter TSParameter
          highlight! link @lsp.type.property TSProperty
          highlight! link @lsp.type.regexp TSStringRegex
          highlight! link @lsp.type.string TSString
          highlight! link @lsp.type.struct TSType
          highlight! link @lsp.type.type TSType
          highlight! link @lsp.type.typeParameter TSTypeDefinition
          highlight! link @lsp.type.variable TSVariable
          highlight! link DiagnosticUnnecessary TSWarning
        endif
        highlight! link TSModuleInfoGood Green
        highlight! link TSModuleInfoBad Red
        " }}}
        " github/copilot.vim {{{
        highlight! link CopilotSuggestion Conceal
        " }}}
    endfunction

    "let g:edge_better_performance = 1
    let s:palette = {
         \  'black':      ['#000000',   '253'],
         \  'bg_dim':     ['#e8ebf0',   '254'],
         \  'bg0':        ['#ffffff',   '231'],
         \  'bg1':        ['#fafafa',   '231'],
         \  'bg2':        ['#eef1f4',   '255'],
         \  'bg3':        ['#e8ebf0',   '254'],
         \  'bg4':        ['#dde2e7',   '253'],
         \  'bg_grey':    ['#bcc5cf',   '246'],
         \  'bg_red':     ['#e17373',   '167'],
         \  'diff_red':   ['#f6e4e4',   '217'],
         \  'bg_green':   ['#50A45C',   '107'],
         \  'diff_green': ['#EDFCED',   '150'],
         \  'bg_blue':    ['#4CAFE7',   '68'],
         \  'diff_blue':  ['#C3D6E8',   '153'],
         \  'bg_purple':  ['#AB57B4',   '134'],
         \  'diff_yellow':['#f0ece2',   '183'],
         \  'fg':         ['#000000',   '240'],
         \  'red':        ['#d05858',   '167'],
         \  'yellow':     ['#be7e05',   '172'],
         \  'green':      ['#067D17',   '107'],
         \  'cyan':       ['#00627A',   '73'],
         \  'blue':       ['#008DDE',   '68'],
         \  'purple':     ['#871094',   '134'],
         \  'grey':       ['#8C8C8C',   '245'],
         \  'grey_dim':   ['#C5C5C5',   '249'],
         \  'none':       ['NONE',      'NONE']
    \ }

    let g:edge_colors_override = {
         \  'black':      s:palette.black,
         \  'bg_dim':     s:palette.bg_dim,
         \  'bg0':        s:palette.bg0,
         \  'bg1':        s:palette.bg1,
         \  'bg2':        s:palette.bg2,
         \  'bg3':        s:palette.bg3,
         \  'bg4':        s:palette.bg4,
         \  'bg_grey':    s:palette.bg_grey,
         \  'grey':       s:palette.grey,
         \  'grey_dim':   s:palette.grey_dim,
         \  'fg':         s:palette.fg,
         \  'purple':     s:palette.purple,
         \  'none':       s:palette.none
    \}

    let g:edge_transparent_background = 1

    augroup EdgeCustom
      autocmd!
      autocmd ColorScheme edge call s:edge_custom()
    augroup END

]])
