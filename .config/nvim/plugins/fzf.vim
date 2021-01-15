" Make a command called Project Files that search files from project root
" (if it is a git repo) and if it's not a git repo, it will search in the
" current working directory (pwd).
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

" From -> https://github.com/junegunn/fzf.vim/issues/47
command! ProjectFiles execute 'Files' s:find_git_root()

" Open fzf in a floating window
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8, 'border': 'sharp' } }

let g:fzf_preview_window = 'right:40%'

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
" let g:fzf_history_dir = '~/.local/share/fzf-history'
" let g:fzf_buffers_jump = 1

" let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
"-g '!{node_modules,.git}'

let $FZF_DEFAULT_OPTS = join(
  \ [
    \ '--layout=reverse',
    \ '--bind ' . join(
      \ [
        \ 'ctrl-a:select-all', 'ctrl-d:deselect-all',
        \ 'tab:toggle+up', 'shift-tab:toggle+down',
        \ 'ctrl-p:toggle-preview'
      \ ],
      \ ',',
    \ )
  \ ],
  \ ' ',
\ )

let g:fzf_action = {
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'bel vsplit' }

" Search files with fzf
" nnoremap <silent> <C-p> :ProjectFiles<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <leader>B :Buffers<CR>

" Search word under the cursor
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>

" Search word
nnoremap <leader>ps :Rg<space>

" nnoremap <leader>t :Tags<CR>
" nnoremap <leader>m :Marks<CR>

autocmd VimEnter * let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
  \ }

" Terminal buffer options for fzf
autocmd! FileType fzf
" autocmd  BufEnter,FileType fzf hi Normal guibg=#000000 ctermbg=232
autocmd  FileType fzf set laststatus=0 noruler
  \| autocmd BufLeave <buffer> set laststatus=2 ruler
