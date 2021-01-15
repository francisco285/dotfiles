" Put this on your .vimrc for loading it for specific file types:
" au FileType c,cpp,objc,objcpp call rainbow#load()
" or just this to enable it globally:
" let g:rainbow_active = 1

autocmd BufEnter *.js,*.py call rainbow#load()

let g:rainbow_guifgs = [
            \ '#ff0000',
            \ '#ffff00',
            \ '#00ffff',
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
