autocmd FileType javascript nnoremap <silent> <buffer> <F9> :<c-u>echo "Running <c-r>=expand('%:t')<cr>..." <bar> !node <c-r>=expand('%:p')<cr><cr>
autocmd FileType python nnoremap <silent> <buffer> <F9> :<c-u>echo "Running <c-r>=expand('%:t')<cr>..." <bar> !python3.8 <c-r>=expand('%:p')<cr><cr>
autocmd FileType html,vim set matchpairs+=<:>
autocmd FileType help set relativenumber
autocmd FileType help set number

augroup text_abbreviations
  autocmd!
  autocmd FileType text abbreviate :bullet: •
augroup end
