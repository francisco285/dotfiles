" Put this on your .vimrc for loading it for specific file types:
" au FileType c,cpp,objc,objcpp call rainbow#load()
" or just this to enable it globally:
autocmd VimEnter * call rainbow#load() | autocmd FileType * call rainbow#load()

let g:rainbow_guifgs = [
            \ 'Orchid',
            \ '#F03030',
            \ 'LightSkyBlue',
            \ 'White',
            \ 'Gold'
            \ ]

" let g:rainbow_guifgs = [
"             \ '#458588',
"             \ '#b16286',
"             \ '#cc241d',
"             \ '#d65d0e',
"             \ '#458588',
"             \ '#b16286',
"             \ '#cc241d',
"             \ '#d65d0e',
"             \ '#458588',
"             \ '#b16286',
"             \ '#cc241d',
"             \ '#d65d0e',
"             \ '#458588',
"             \ '#b16286',
"             \ '#cc241d',
"             \ '#d65d0e',
"             \ ]
