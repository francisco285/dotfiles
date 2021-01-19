autocmd FileType html,vim set matchpairs+=<:>
autocmd FileType help set relativenumber
autocmd FileType help set number

nnoremap <silent> <F9> :call <sid>run()<cr>

function! s:run() abort
  if &filetype == 'javascript'
    execute "!node " . expand('%:p')
  elseif &filetype == 'python'
    execute "!python3.8 " . expand('%:p')
  elseif &filetype == 'cpp'
    execute '!g++ ' . shellescape('%') . ' -o ' . shellescape('%:r') . ' && ./' . shellescape('%:r')
  endif
endfunction

augroup text_abbreviations
  autocmd!
  autocmd FileType text abbreviate :bullet: •
augroup end
