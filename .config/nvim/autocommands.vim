augroup line_numbers
  autocmd!
  autocmd BufLeave,WinLeave,FocusLost   * set norelativenumber
  autocmd BufEnter,WinEnter,FocusGained * set relativenumber
augroup end

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
augroup remember_cursor_position
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ |   exe "normal! g`\""
        \ | endif
augroup END

augroup cursorline_and_colorcolumn
  autocmd!
  autocmd BufEnter,WinEnter,FocusGained * setlocal cursorline colorcolumn=79,80
  autocmd BufLeave,WinLeave,FocusLost   * setlocal nocursorline colorcolumn=
augroup END
