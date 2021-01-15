command BeGood call s:beGood()

function! s:beGood() abort
  VimBeGood
  setlocal winhighlight=Normal:ActiveWindow
  setlocal cursorline
  autocmd BufEnter <buffer> setlocal winhighlight=Normal:ActiveWindow
  autocmd BufLeave <buffer> setlocal winhighlight=Normal:InactiveWindow
endfunction
