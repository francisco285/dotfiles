" let g:floaterm_autoinsert = 1
let g:floaterm_autoclose = 2 " Always close floaterm window once the job is done

" Title string, $1 means 'number of the current floaterm window' and $1 means 'number of total floaterm windows'
let g:floaterm_title = 'Terminal $1/$2'

" 20% Transparency
let g:floaterm_winblend = 20

hi Floaterm guibg=NONE
hi FloatermBorder guifg=#7199EE guibg=NONE

let g:floaterm_width = 0.8
let g:floaterm_height = 0.8

nnoremap <silent> <c-space>t :FloatermToggle<CR>
nnoremap <silent> <c-space>n :FloatermNew<CR>
nnoremap <silent> <c-space>q :FloatermKill<CR>
nnoremap <silent> <c-space>h :FloatermPrev<CR>
nnoremap <silent> <c-space>j :FloatermFirst<CR>
nnoremap <silent> <c-space>k :FloatermLast<CR>
nnoremap <silent> <c-space>l :FloatermNext<CR>

tnoremap <silent> <c-space>t <c-\><c-n>:FloatermToggle<CR>
tnoremap <silent> <c-space>n <c-\><c-n>:FloatermNew<CR>
tnoremap <silent> <c-space>q <c-\><c-n>:FloatermKill<CR>
tnoremap <silent> <c-space>h <c-\><c-n>:FloatermPrev<CR>
tnoremap <silent> <c-space>j <c-\><c-n>:FloatermFirst<CR>
tnoremap <silent> <c-space>k <c-\><c-n>:FloatermLast<CR>
tnoremap <silent> <c-space>l <c-\><c-n>:FloatermNext<CR>

nnoremap <silent> <F21> :<c-u>call <sid>run()<cr>

function! s:run() abort
  if &filetype == 'javascript'
    execute "FloatermNew --title=Node.js --autoclose=0 node " . shellescape('%')
  elseif &filetype == 'python'
    execute "FloatermNew --title=Python --autoclose=0 python3.8 " . shellescape('%')
  elseif &filetype == 'cpp'
    execute "FloatermNew --title=C++ --autoclose=0 g++ " . shellescape(expand('%')) . ' -o ' . shellescape(expand('%:r')) . ' && ./' . shellescape(expand('%:r'))
  endif
endfunction

nnoremap <silent> <leader>o :FloatermNew --height=0.8 --width=0.8 lf<cr>
nnoremap <silent> <leader>O :execute 'FloatermNew --height=0.8 --width=0.8 lf'. ' ' . getcwd()<cr>

autocmd FileType floaterm autocmd InsertLeave <buffer> set number relativenumber
