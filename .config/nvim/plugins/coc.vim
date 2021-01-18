let g:coc_global_extensions = [
  \ 'coc-vimlsp',
  \ 'coc-emmet',
  \ 'coc-explorer',
  \ 'coc-marketplace',
  \ 'coc-snippets',
  \ 'coc-css',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-python',
  \ 'coc-tsserver'
  \ ]

" Highlight twin words {{{
  hi CocHighlightText guibg=#292d3e
  hi CocHighlightRead guibg=#292d3e
  hi CocHighlightWrite guibg=#292d3e
  autocmd CursorHold * silent call CocActionAsync('highlight')
" }}}

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" coc explorer {{{
nnoremap <silent> <leader>e :CocCommand explorer<CR>
nnoremap <silent> <leader>E :exe ":CocCommand explorer " . getcwd()<cr>

" Deleting the coc-explorer buffer would lead to annoying bugs
" Also, unmap wouldn't fit here because it would trigger the 'd' action (delete file)
autocmd FileType coc-explorer nnoremap <buffer> <leader>d <Nop>

autocmd FileType coc-explorer set number relativenumber
" coc explorer }}}

nmap <leader>r <Plug>(coc-rename)
nnoremap <leader>R :CocSearch <C-R>=expand("<cword>")<CR><CR>

" use <C-space> to trigger completion menu
inoremap <silent> <expr> <C-space> coc#refresh()

" Use ;; to expand a snippet without having to wait for the pop up menu to show up
imap <silent> <expr> ;;
      \ <SID>check_back_space() ? ";;" : "\<Plug>(coc-snippets-expand)"

" Use tab to trigger or hop through completion menu
  inoremap <silent> <expr> <Tab>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()

" Use shift + tab to go back in suggestions
  inoremap <silent> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

  " function! s:check_new_line() abort
  "   return col('.') - 1 ==? 0
  " endfunction

  " function! s:check_character() abort
  "   let col = col('.') - 1
  "   let is_white_space = getline('.')[col - 1]  =~? '\s'
  "   return !is_white_space
  " endfunction

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~? '\s'
  endfunction

inoremap <silent> <expr> <C-j> pumvisible() ? "\<C-n>" : coc#refresh()
inoremap <silent> <expr> <C-k> pumvisible() ? "\<C-p>" : coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

augroup coc_goto_mappings
  " GoTo code navigation.
  autocmd FileType * nmap <silent> <leader>gd <Plug>(coc-definition)
  autocmd FileType * nmap <silent> <leader>gy <Plug>(coc-type-definition)
  autocmd FileType * nmap <silent> <leader>gi <Plug>(coc-implementation)
  autocmd FileType * nmap <silent> <leader>gr <Plug>(coc-references)
augroup END
