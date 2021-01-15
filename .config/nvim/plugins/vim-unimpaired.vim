" Insert line above or below
" https://github.com/tpope/vim-unimpaired/pull/164
autocmd VimEnter * nnoremap <silent> [<Space> :<C-U>call append(line('.') - 1, repeat([''], v:count1))<CR>
autocmd VimEnter * nnoremap <silent> ]<Space> :<C-U>call append(line('.'), repeat([''], v:count1))<CR>

" Insert line above and below
autocmd VimEnter * nnoremap <silent> []<space>
    \ :<C-U>call append(line('.') - 1, repeat([''], v:count1))<bar>call append(line('.'), repeat([''], v:count1))<CR>
