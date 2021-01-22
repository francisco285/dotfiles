function! s:deleteEmptyBuffer() abort
  if &ft ==? 'coc-explorer'
    return
  endif
  if s:previousBufferIsEmtpy()
    if &confirm
      set noconfirm
      silent! bd #
      set confirm
    else
      silent! bd #
    endif
  endif
endfunction

let g:PreviousBufferHasNoName      = 0
let g:PreviousBufferWasNotModified = 0

function! s:previousBufferIsEmtpy() abort
  return g:PreviousBufferHasNoName && g:PreviousBufferWasNotModified
endfunction

autocmd BufEnter * call s:deleteEmptyBuffer()
autocmd BufLeave * call s:setBufLeave()

function! s:setBufLeave() abort
  let g:PreviousBufferHasNoName      = bufname('%') ==? ''
  let g:PreviousBufferWasNotModified = &modified    ==  0
endfunction
