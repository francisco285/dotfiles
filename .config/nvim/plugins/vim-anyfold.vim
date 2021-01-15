filetype plugin indent on " required
syntax on                 " required

augroup anyfold
    autocmd!
    autocmd Filetype * AnyFoldActivate
augroup END

let g:anyfold_fold_comments=1
set foldlevel=0
hi Folded term=NONE cterm=NONE

" Open all folds
set foldlevel=99

" disable anyfold for large files
let g:LargeFile = 1000000 " file is large if size greater than 1MB
autocmd BufReadPre,BufRead * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
function LargeFile()
    augroup anyfold
        autocmd! " remove AnyFoldActivate
        autocmd Filetype * setlocal foldmethod=indent " fall back to indent folding
    augroup END
endfunction

" vim-anyfold doesn't require mappings because it uses default vim keybindings for folding
