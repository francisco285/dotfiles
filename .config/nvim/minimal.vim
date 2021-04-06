set noundofile
set nowritebackup
set noswapfile
set nowritebackup

let s:plugins_path = stdpath('data') . '/plugged'

if !isdirectory(s:plugins_path)
  mkdir(s:plugins_path, 'p')
endif

call plug#begin(s:plugins_path)
" Plugins go here
call plug#end()
