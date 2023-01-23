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
      call edge#highlight('MethodItalic', ['#00627A', '68'], l:palette.none, 'italic')
      call edge#highlight('Function', ['#871094', '68'], l:palette.none)
      call edge#highlight('FuncItalic', ['#871094', '68'], l:palette.none, 'italic')
      call edge#highlight('Number', ['#1750EB', '68'], l:palette.none)
      call edge#highlight('Keyword', ['#0033B3', '134'], l:palette.none)
      call edge#highlight('Attribute', ['#174AD4', '172'], l:palette.none)
      call edge#highlight('Comment', ['#8C8C8C', '172'], l:palette.none, 'italic')
      call edge#highlight('PreProc', ['#8C8C8C', '172'], l:palette.none, 'bold,italic')
      call edge#highlight('CurrentWord', l:palette.none, ['#e5e5ff', '253'])
      call edge#highlight('Visual', l:palette.none, ['#A6D2FF', '253'])
      call edge#highlight('VisualNOS', l:palette.none, ['#A6D2FF', '253'], 'underline')
      call edge#highlight('SignColumn', l:palette.none, ['#f3f4f4', '253'])
      call edge#highlight('VertSplit', ['#f3f4f4', '253'], ['#f3f4f4', '253'])
      call edge#highlight('LineNr', l:palette.grey, ['#f3f4f4', '253'])
      call edge#highlight('CursorLine', l:palette.none, ['#fcfaed', '255'])
      call edge#highlight('CursorLineNr', l:palette.none, ['#fcfaed', '255'])
      call edge#highlight('CursorLineSign', l:palette.none, ['#fcfaed', '255'])
      call edge#highlight('Folded', l:palette.grey, ['#e9f5e6', 'NONE'])
      call edge#highlight('Todo', ['#008dde', '167'], l:palette.none, 'italic')
      call edge#highlight('StringEscape', ['#0037A6', '172'], l:palette.none)
      call edge#highlight('StringRegex', l:palette.none, ['#EDFCED', '172'])
      call edge#highlight('Black', ['#000000', '240'], l:palette.none)
      call edge#highlight('BlackItalic', ['#000000', '240'], l:palette.none, 'italic')
      call edge#highlight('Link', ['#4585BE', '167'], l:palette.none)
      call edge#highlight('Label', ['#4A86E8', '167'], l:palette.none)
      call edge#highlight('IndentChar', ['#e6e6e6', '240'], l:palette.none)
      call edge#highlight('IndentContextChar', ['#8c8c8c', '240'], l:palette.none)
      call edge#highlight('IndentContextStart', l:palette.none, l:palette.none, 'underline', ['#8c8c8c', '240'])
      call edge#highlight('GreenSign', ['#C9DEC1', '107'], ['#f3f4f4', '253'])
      call edge#highlight('BlueSign', ['#C3D6E8', '68'], ['#f3f4f4', '253'])

      call edge#highlight('TSStrong', l:palette.none, l:palette.none, 'bold')
      call edge#highlight('TSEmphasis', l:palette.none, l:palette.none, 'italic')
      call edge#highlight('TSUnderline', l:palette.none, l:palette.none, 'underline')
      call edge#highlight('TSNote', l:palette.bg0, l:palette.blue, 'bold')
      call edge#highlight('TSWarning', l:palette.bg0, ['#F5EAC1', '172'], 'bold')
      call edge#highlight('TSDanger', l:palette.bg0, l:palette.red, 'bold')

      " NvimTree
      highlight! link NvimTreeGitIgnored Conceal

      " Indent Blankline
      highlight! link IndentBlanklineChar IndentChar
      highlight! link IndentBlanklineContextChar IndentContextChar
      highlight! link IndentBlanklineContextStart IndentContextStart

      " Gitsigns
      highlight! link GitSignsAdd GreenSign
      highlight! link GitSignsChange BlueSign
      highlight! link GitSignsDelete RedSign
      highlight! link GitSignsAddNr Green
      highlight! link GitSignsChangeNr Blue
      highlight! link GitSignsDeleteNr Red
      highlight! link GitSignsAddLn DiffAdd
      highlight! link GitSignsChangeLn DiffChange
      highlight! link GitSignsDeleteLn DiffDelete
      call edge#highlight('GitSignsCurrentLineBlame', l:palette.grey_dim, l:palette.none)

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

      " General Treesitter language highlight
      highlight! link @annotation Annotation
      highlight! link @attribute Attribute
      highlight! link @boolean Keyword
      highlight! link @character Green
      highlight! link @comment Comment
      highlight! link @conditional Keyword
      highlight! link @constant Constant
      highlight! link @constant.builtin Constant
      highlight! link @constant.macro Constant
      highlight! link @constructor Black
      highlight! link @exception Keyword
      highlight! link @field Field
      highlight! link @float Number
      highlight! link @function Function
      highlight! link @function.call FuncItalic
      highlight! link @function.builtin Keyword
      highlight! link @function.macro FuncItalic
      highlight! link @include Keyword
      highlight! link @keyword Keyword
      highlight! link @keyword.return Keyword
      highlight! link @keyword.function Keyword
      highlight! link @keyword.operator Keyword
      highlight! link @label Label
      highlight! link @method Method
      highlight! link @method.call MethodItalic 
      highlight! link @namespace Keyword
      highlight! link @none Fg
      highlight! link @number Number
      highlight! link @operator Black
      highlight! link @operator.bracket Black
      highlight! link @parameter Black
      highlight! link @parameter.reference Field
      highlight! link @property Field
      highlight! link @punctuation.bracket Black
      highlight! link @punctuation.delimiter Black
      highlight! link @punctuation.special Black
      highlight! link @repeat Keyword
      highlight! link @storageclass Purple
      highlight! link @string Green
      highlight! link @string.escape StringEscape
      highlight! link @string.regex StringRegex
      highlight! link @symbol Attribute
      highlight! link @tag Keyword
      highlight! link @tag.delimiter Black
      highlight! link @text Green
      highlight! link @text.note Todo
      highlight! link @strike Grey
      highlight! link @math Green
      highlight! link @todo Todo
      highlight! link @type Black
      highlight! link @type.builtin Keyword
      highlight! link @uri Link
      highlight! link @variable Black
      highlight! link @variable.builtin Keyword
    endfunction
    
    augroup EdgeCustom
      autocmd!
      autocmd ColorScheme edge call s:edge_custom()
    augroup END

    "let g:edge_better_performance = 1
    let g:edge_colors_override = {'bg0': ['#ffffff', '234'], 'fg0': ['#000000', '240']}
    let g:edge_transparent_background = 1
]])
