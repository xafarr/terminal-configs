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
      let l:palette = edge#get_palette('aura', 0, {})
      " Define a highlight group.
      " The first parameter is the name of a highlight group,
      " the second parameter is the foreground color,
      " the third parameter is the background color,
      " the fourth parameter is for UI highlighting which is optional,
      " and the last parameter is for `guisp` which is also optional.
      " See `autoload/edge.vim` for the format of `l:palette`.
      call edge#highlight('CurrentWord', l:palette.none, ['#e3e4e5', '237'])
      call edge#highlight('Visual', l:palette.none, ['#cbe5f8', '237'])
      call edge#highlight('VisualNOS', l:palette.none, ['#cbe5f8', '237'], 'underline')
    endfunction
    
    augroup EdgeCustom
      autocmd!
      autocmd ColorScheme edge call s:edge_custom()
    augroup END

    let g:edge_style = 'aura'
    let g:edge_better_performance = 1
]])
