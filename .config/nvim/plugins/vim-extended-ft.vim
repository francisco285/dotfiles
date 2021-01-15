if exists('g:colors_name')
  if g:colors_name ==# 'gruvbox'
    highlight ExtSearch guibg=none guifg=#FE8019
  elseif g:colors_name ==# 'vim-material'
    highlight ExtSearch guibg=none guifg=#E91E63
  else
    highlight link ExtSearch ErrorMsg
  endif
endif
