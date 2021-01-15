" let g:floaterm_autoinsert = 1
let g:floaterm_autoclose = 2 " Always close floaterm window once the job is finished

" Title string, $1 means 'number of the current floaterm window' and $1 means 'number of total floaterm windows'
let g:floaterm_title = 'Terminal $1/$2'

" 20% Transparency
let g:floaterm_winblend = 20

" Set floaterm window's background to black
  " hi Floaterm guibg=black
" Set floating window border line color to cyan, and background to orange
  " hi FloatermBorder guibg=orange guifg=cyan
  hi FloatermBorder guifg=#7199EE guibg=NONE

let g:floaterm_width = 0.8
let g:floaterm_height = 0.8

" Normal mode:
nnoremap <silent> <c-space>t :FloatermToggle<CR>
nnoremap <silent> <c-space>n :FloatermNew<CR>
nnoremap <silent> <c-space>q :FloatermKill<CR>
nnoremap <silent> <c-space>h :FloatermPrev<CR>
nnoremap <silent> <c-space>j :FloatermFirst<CR>
nnoremap <silent> <c-space>k :FloatermLast<CR>
nnoremap <silent> <c-space>l :FloatermNext<CR>

" Terminal mode:
tnoremap <silent> <c-space>t <c-\><c-n>:FloatermToggle<CR>
tnoremap <silent> <c-space>n <c-\><c-n>:FloatermNew<CR>
tnoremap <silent> <c-space>q <c-\><c-n>:FloatermKill<CR>
tnoremap <silent> <c-space>h <c-\><c-n>:FloatermPrev<CR>
tnoremap <silent> <c-space>j <c-\><c-n>:FloatermFirst<CR>
tnoremap <silent> <c-space>k <c-\><c-n>:FloatermLast<CR>
tnoremap <silent> <c-space>l <c-\><c-n>:FloatermNext<CR>

autocmd FileType javascript nnoremap <silent> <buffer> <F21> :<c-u>echo "Running '<c-r>=expand("%:t")<cr>'..." <bar> FloatermNew --title=Node.js --autoclose=0 node\ <c-r>=expand('%:p')<cr><cr>
autocmd FileType python nnoremap <silent> <buffer> <F21> :<c-u>echo "Running '<c-r>=expand("%:t")<cr>'..." <bar> FloatermNew --title=Python\ 3.8 --autoclose=0 python3.8\ <c-r>=expand('%:p')<cr><cr>

nnoremap <silent> <c-o> :FloatermNew --height=0.8 --width=0.8 lf<CR>

" autocmd FileType floaterm autocmd InsertLeave <buffer> set number relativenumber
" autocmd FileType floaterm autocmd InsertEnter <buffer> set nonumber norelativenumber
