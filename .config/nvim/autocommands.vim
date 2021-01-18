augroup line_numbers
  autocmd!
  autocmd BufLeave,WinLeave,FocusLost   * set norelativenumber
  autocmd BufEnter,WinEnter,FocusGained * set relativenumber
augroup end

augroup remember_cursor_position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

augroup cursorline_and_colorcolumn
  autocmd!
  autocmd BufEnter,WinEnter,FocusGained * setlocal cursorline colorcolumn=79,80
  autocmd BufLeave,WinLeave,FocusLost   * setlocal nocursorline colorcolumn=
augroup END
