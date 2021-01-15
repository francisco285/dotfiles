if exists('g:loaded_personal_functions')
  finish
endif
let g:loaded_personal_functions = 1

function! FormatDirectory(dir) abort
  if !(type(a:dir) == type(""))
    return
  endif

  if a:dir ==# $HOME
    return '~'
  endif

  let folders = split(a:dir, '/')

  if len(folders) >= 2
    let first_and_second_folders = '/' . join(folders[0:1], '/')
    if first_and_second_folders ==# $HOME
      return '~' . '/' . join(folders[2:-1], '/')
    endif
  else
    return a:dir
  endif
endfunction
