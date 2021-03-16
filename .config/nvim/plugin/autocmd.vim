augroup remember_cursor_position
  autocmd!
  autocmd BufReadPost *
        \   if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ |   exe "normal! g`\""
        \ | endif
augroup END

augroup terminal_insert_as_default_mode
  autocmd!
  autocmd TermOpen * startinsert
augroup END

augroup buf_auto_delete
  autocmd!
  autocmd BufLeave,WinLeave * lua require('autoload.buffer').set_auto_delete()
augroup END

augroup yank_highlight
  autocmd!
  autocmd TextYankPost * lua vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 40 })
augroup END

augroup consistent_highlights
  autocmd!
  autocmd Colorscheme * lua require('autoload.highlight')
augroup END

augroup auto_fill_location_list
    autocmd!
    " https://www.youtube.com/watch?v=IoyW8XYGqjM
    autocmd BufWrite,BufEnter,InsertLeave * lua vim.lsp.diagnostic.set_loclist({ open_loclist = false })
augroup END
