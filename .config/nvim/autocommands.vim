augroup line_numbers
  autocmd!
  autocmd BufLeave,WinLeave,FocusLost   * set norelativenumber
  autocmd BufEnter,WinEnter,FocusGained * set relativenumber
augroup end

augroup remember_cursor_position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
