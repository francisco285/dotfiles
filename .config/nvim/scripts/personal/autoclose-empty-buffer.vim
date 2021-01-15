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

function! s:previousBufferIsEmtpy() abort
  return g:PreviousBufferHasNoName && g:PreviousBufferWasNotModified
endfunction

function! PPreviousBufferIsEmtpy() abort
  let bufferHasNoName = bufname('#') ==? ''
  let bufferWasNotModified = !getbufvar(bufnr(expand('#')), '&modified')
  return bufferHasNoName && bufferWasNotModified
endfunction

function! PPreviousBufferHasNoName() abort
  return bufname('#') ==? ''
endfunction

function! PPreviousBufferWasNotModified() abort
  return !getbufvar(bufnr(expand('#')), '&modified')
endfunction

autocmd VimEnter * autocmd BufEnter * call s:deleteEmptyBuffer()
autocmd VimEnter * autocmd BufLeave * call s:setBufLeave()

function! s:setBufLeave() abort
  let g:PreviousBufferHasNoName = bufname('%') ==? ''
  let g:PreviousBufferWasNotModified = &modified == 0
endfunction
