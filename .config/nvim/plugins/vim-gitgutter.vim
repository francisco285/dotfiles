" Gitgutter signs

" let g:gitgutter_max_signs = 10000
" let g:gitgutter_sign_added = '+'
" let g:gitgutter_sign_modified = '!'
" let g:gitgutter_sign_removed = '_'
" let g:gitgutter_sign_removed_first_line = '‾'
" "let g:gitgutter_sign_removed_above_and_below = '{'
" let g:gitgutter_sign_modified_removed = '!1'

" │

let g:gitgutter_max_signs = 500
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '│'
let g:gitgutter_sign_removed_first_line = '│'
let g:gitgutter_sign_removed_above_and_below = '}'
let g:gitgutter_sign_modified_removed = '│'

highlight GitGutterAdd          guifg=#00FF00
highlight GitGutterChange       guifg=#FFFF00
highlight GitGutterDelete       guifg=#FF0000
highlight GitGutterChangeDelete guifg=#0000FF

" autocmd BufEnter,WinEnter,FocusGained * set signcolumn=yes
" autocmd BufLeave,WinLeave,FocusLost   * set signcolumn=no

" Signify-signs

" `+`     This line was added.
" `!`     This line was modified.
" `_1`    The number of deleted lines below this sign. If the number is larger
" `99`    than 9, the `_` will be omitted. For numbers larger than 99, `_>`
" `_>`    will be shown instead.
" `!1`    This line was modified and the lines below were deleted.
" `!>`    It is a combination of `!` and `_`. If the number is larger than 9,
"       `!>` will be shown instead.
" `‾`     The first line was removed. It's a special case of the `_` sign.

" Don't map keys automatically, instead let user do it by theirself
let g:gitgutter_map_keys = 0
