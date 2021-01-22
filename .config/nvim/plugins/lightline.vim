function! ReturnBranchString() abort
  let options = ["\ue725", "\uE0A0"]
  if !exists('g:loaded_fugitive') || g:loaded_fugitive == 0 || FugitiveHead() ==# ''
    return ''
  endif

  return options[0] . ' ' . FugitiveHead()
endfunction

function! GitStatus() abort
  if !exists('g:loaded_fugitive') || g:loaded_fugitive == 0 || FugitiveHead() ==# ''
    return ''
  endif

  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

if !exists('g:lightline')
      let g:lightline = {}
endif

let g:lightline.active = {
      \   'left': [
      \     [ 'mode', 'paste',  ],
      \     [ 'cocstatus', 'readonly', 'filename', 'modified' ]
      \   ],
      \ }

let g:lightline.enable = {
      \ 'tabline': 1
\ }

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }

let g:lightline.tab_component = {
      \ }
let g:lightline.tab_component_function = {
      \ 'filename': 'lightline#tab#filename',
      \ 'modified': 'lightline#tab#modified',
      \ 'readonly': 'lightline#tab#readonly',
      \ 'tabnum': 'Tab_num',
      \ 'branch_string': 'ReturnBranchString',
      \ 'git_status': 'GitStatus'
      \ }
let g:lightline.component = {
      \ 'bufinfo': '%{bufname("%")}:%{bufnr("%")}',
      \ 'vim_logo': "\ue7c5",
      \ 'mode': '%{lightline#mode()}',
      \ 'absolutepath': '%F',
      \ 'relativepath': '%f',
      \ 'filename': '%t',
      \ 'filesize': "%{HumanSize(line2byte('$') + len(getline('$')))}",
      \ 'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
      \ 'filetype': '%{&ft!=#""?&ft:"no ft"}',
      \ 'modified': '%M',
      \ 'bufnum': '%n',
      \ 'paste': '%{&paste?"PASTE":""}',
      \ 'readonly': '%R',
      \ 'charvalue': '%b',
      \ 'charvaluehex': '%B',
      \ 'percent': '',
      \ 'percentwin': '%P',
      \ 'spell': '%{&spell?&spelllang:""}',
      \ 'lineinfo': '☰ %1p%%  %l:%-2v',
      \ 'line': '%l',
      \ 'column': '%c',
      \ 'close': '%999X X ',
      \ 'winnr': '%{winnr()}',
      \ 'git_status': '%{GitStatus()}'
      \ }

function! FormatCwd() abort
  return FormatDirectory(getcwd())
endfunction

let g:lightline.component_function = {
      \   'cocstatus': 'coc#status',
      \   'gitbranch': 'FugitiveHead',
      \   'branch_string': 'ReturnBranchString',
      \   'current_working_directory': 'FormatCwd'
      \ }

let g:lightline.component_expand = {
      \ 'buffers': 'lightline#bufferline#buffers',
      \ }

let g:lightline.component_type = {
      \ 'buffers': 'tabsel'
      \ }

let g:lightline.tabline = {
      \ 'left': [ [ 'vim_logo', 'buffers' ] ],
      \ 'right': [ [ 'git_status', 'branch_string', 'current_working_directory'] ]
      \ }

let g:lightline.tab = {
      \ 'active': [ 'tabnum', 'devicons_filetype', 'filename', 'modified' ],
      \ 'inactive': [ 'tabnum', 'devicons_filetype', 'filename', 'modified' ] }

let g:lightline.component_raw = {'buffers': 1}

let g:lightline#bufferline#clickable = 1

let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#enable_nerdfont = 1

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)
