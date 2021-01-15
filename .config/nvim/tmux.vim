function! s:tmuxRenameWindow() abort
  if expand("%:t") !=? ''
    call system("tmux rename-window " . shellescape(expand("%:t")))
  endif
endfunction

" Tmux rename
if exists('$TMUX')
  autocmd BufEnter,FocusGained * call s:tmuxRenameWindow()
  autocmd VimLeave * call system("tmux setw automatic-rename")
endif
