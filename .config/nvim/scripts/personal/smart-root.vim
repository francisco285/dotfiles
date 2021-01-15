if !exists('g:loaded_personal_functions')
  finish
endif

if exists('g:loaded_personal_smart_root')
  finish
endif
let g:loaded_smart_root = 1

function! SimpleRoot()
  let root = expand('%:p:h')

  execute 'lcd ' . root
endfunction
command! SimpleRoot call SimpleRoot()

function! GitRoot()
    let root = systemlist('git rev-parse --show-toplevel')[0]

    if v:shell_error
      return
    else
      execute 'lcd ' . root
    endif
endfunction
command! GitRoot call GitRoot()

" :SmartRoot | Change directory to root of Git repository or fallback to current directory
function! SmartRoot()
  execute 'lcd ' . expand('%:p:h')
  let root = systemlist('git rev-parse --show-toplevel')[0]

  if v:shell_error
    let root = expand('%:p:h')
    let gitMsg = 'Not a git repository ➜ '
  else
    let gitMsg = 'Git repository ➜ '
  endif

  execute 'lcd ' . root
endfunction
command! SmartRoot call SmartRoot()
" From -> https://github.com/junegunn/dotfiles/blob/master/vimrc

function! s:displayRoot()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    let gitMsg = 'Not a git repository ➜ '
  else
    let gitMsg = 'Git repository ➜ '
  endif

  highlight RootMsg guifg=#AFAFFF ctermfg=147
  echohl RootMsg
  echo gitMsg . FormatDirectory(getcwd())
  echohl none
endfunction

SmartRoot
