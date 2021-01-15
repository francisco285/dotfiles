let g:dashboard_default_executive ='telescope'

let g:dashboard_custom_header = [
  \ '',
  \ '███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
  \ '████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
  \ '██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
  \ '██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
  \ '██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
  \ '╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
  \ '',
  \ ]

autocmd FileType dashboard call s:dashboard_set_local_settings()
      \ | call s:dashboard_set_mappings()
      \ | call s:dashboard_set_autocmds()
      \ | call s:dashboard_set_global_settings()

nnoremap <silent> <leader>d :call <SID>dashboard_main_screen()<CR>

function! s:dashboard_main_screen() abort
  if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if !(bufname('%') ==? '' && &modified == 0)
      Dashboard
      silent bd #
    else
      Dashboard
    endif
  else
      silent bdelete
  endif
endfunction

function! s:dashboard_set_global_settings() abort
  set showtabline=0 laststatus=0
endfunction

function! s:dashboard_set_local_settings() abort
  setlocal signcolumn=no cursorline nonumber norelativenumber colorcolumn=
endfunction

function! s:dashboard_set_autocmds()
  augroup dashboard_autocmds
    autocmd!
    autocmd VimResized <buffer> Dashboard
    autocmd BufEnter,WinEnter,FocusGained <buffer> setlocal showtabline=0 laststatus=0 signcolumn=no colorcolumn= cursorline nonumber norelativenumber
    autocmd BufLeave,WinLeave             <buffer> set      showtabline=2 laststatus=2
  augroup END
endfunction

function! s:smart_find_file() abort
  let s:gitRoot = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
  if s:gitRoot !=# ''
    silent lua require'telescope.builtin'.git_files{}
  else
    silent lua require'telescope.builtin'.find_files{}
  endif
endfunction

" \ 'description': [' Recently last session                [1]'],
let g:dashboard_custom_section={
  \ '1_Open_explorer': {
      \ 'description': [' Open explorer                        [1]'],
      \ 'command': 'FloatermNew lf' },
  \ '2_find_file': {
      \ 'description': [' Find file                            [2]'],
      \ 'command': function('s:smart_find_file') },
  \ '3_Recently_opened_files': {
      \ 'description': [' Recent files                         [3]'],
      \ 'command': "lua require'telescope.builtin'.oldfiles{}" },
  \ '4_Grep_word': {
      \ 'description': [' Grep word                            [4]'],
      \ 'command': "lua require'telescope.builtin'.live_grep{}" },
  \ '5_Grep_word': {
      \ 'description': [' New file                             [5]'],
      \ 'command': 'enew' },
  \ '6_Open_config': {
      \ 'description': [' Settings                             [6]'],
      \ 'command': 'edit ~/.config/nvim/init.vim' },
  \ '7_Exit_neovim': {
      \ 'description': [' Exit                                 [7]'],
      \ 'command': 'qall' },
  \ }

function! s:dashboard_set_mappings()
  nnoremap <silent> <buffer> 1 :FloatermNew lf<cr>
  nnoremap <silent> <buffer> 2 :call <sid>smart_find_file()<cr>
  nnoremap <silent> <buffer> 3 :lua require'telescope.builtin'.oldfiles{}<cr>
  nnoremap <silent> <buffer> 4 :lua require'telescope.builtin'.live_grep{}<cr>
  nnoremap <silent> <buffer> 5 :enew<cr>
  nnoremap <silent> <buffer> 6 :edit ~/.config/nvim/init.vim<cr>
  nnoremap <silent> <buffer> 7 :qall<cr>

  nnoremap <buffer> a <nop>
  " nnoremap <buffer> b <nop>
  nnoremap <buffer> c <nop>
  nnoremap <buffer> d <nop>
  " nnoremap <buffer> e <nop>
  nnoremap <buffer> f <nop>
  " nnoremap <buffer> g <nop>
  "noremap h <buffer> <nop>n
  nnoremap <buffer> i <nop>
  "noremap j <buffer> <nop>n
  "noremap k <buffer> <nop>n
  "noremap l <buffer> <nop>n
  nnoremap <buffer> m <nop>
  nnoremap <buffer> n <nop>
  nnoremap <buffer> o <nop>
  nnoremap <buffer> p <nop>
  nnoremap <buffer> q <nop>
  nnoremap <buffer> r <nop>
  nnoremap <buffer> s <nop>
  nnoremap <buffer> t <nop>
  nnoremap <buffer> u <nop>
  nnoremap <buffer> v <nop>
  " nnoremap <buffer> w <nop>
  nnoremap <buffer> x <nop>
  " nnoremap <buffer> y <nop>
  nnoremap <buffer> z <nop>
  nnoremap <buffer> , <nop>
  nnoremap <buffer> < <nop>
  nnoremap <buffer> . <nop>
  nnoremap <buffer> > <nop>
  nnoremap <buffer> ; <nop>
  nnoremap <buffer> / <nop>
  nnoremap <buffer> ? <nop>
  nnoremap <buffer> = <nop>

  nnoremap <buffer> A <nop>
  " nnoremap <buffer> B <nop>
  nnoremap <buffer> C <nop>
  nnoremap <buffer> D <nop>
  " nnoremap <buffer> E <nop>
  nnoremap <buffer> F <nop>
  " nnoremap <buffer> G <nop>
  "noremap <buffer> H <nop>
  nnoremap <buffer> I <nop>
  "noremap <buffer> J <nop>
  "noremap <buffer> K <nop>
  "noremap <buffer> L <nop>
  nnoremap <buffer> M <nop>
  nnoremap <buffer> N <nop>
  nnoremap <buffer> O <nop>
  nnoremap <buffer> P <nop>
  nnoremap <buffer> Q <nop>
  nnoremap <buffer> R <nop>
  nnoremap <buffer> S <nop>
  nnoremap <buffer> T <nop>
  nnoremap <buffer> U <nop>
  nnoremap <buffer> V <nop>
  " nnoremap <buffer> W <nop>
  nnoremap <buffer> X <nop>
  " nnoremap <buffer> Y <nop>
  nnoremap <buffer> Z <nop>
endfunction
