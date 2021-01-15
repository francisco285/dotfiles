" nnoremap <leader>f <cmd>lua require'telescope.builtin'.git_files{}<CR>
" nnoremap <c-p> <cmd>lua require'telescope.builtin'.find_files{}<CR>

function! s:smart_find_file() abort
  let s:gitRoot = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
  if s:gitRoot !=# ''
    silent lua require'telescope.builtin'.git_files{}
  else
    silent lua require'telescope.builtin'.find_files{}
  endif
endfunction

" https://vim.fandom.com/wiki/User_input_from_a_script
function! s:grepStr()
  call inputsave()
  let word = input('Grep: ')
  call inputrestore()
  " Clear input message {{{
    echo "\r"
    echo ""
  " }}}
  if word !=# ''
    execute "lua require'telescope.builtin'.live_grep{}"
    " For some reason, `execute "normal i" . word` doesn't leave cursor at the end of the line
    execute "normal i" . word . "\<esc>$"
  " Clear input message {{{
    echo "\r"
    echo ""
  " }}}
  endif
endfunction

" -- Grep files as you type (requires rg currently)
" nnoremap <leader>ps <cmd><c-u>lua require('telescope.builtin').live_grep()<cr>
" nnoremap <leader>ps <cmd>lua require'telescope.builtin'.grep_string{}<cr>
nnoremap <leader>s :call <sid>grepStr()<cr>
nnoremap <leader>S :lua require'telescope.builtin'.live_grep{}<cr>

" Search files in history
nnoremap <silent> <c-h> :lua require'telescope.builtin'.oldfiles{}<CR>

" Search buffer
nnoremap <silent> <c-b> :lua require'telescope.builtin'.buffers{}<CR>

" Use git files if possible, otherwise falls back to CWD (Current Working Directory)
nnoremap <silent> <c-p> :<c-u>call <sid>smart_find_file()<cr>

" Search in folder of the current buffer
nnoremap <silent> <c-f> :lua require'telescope.builtin'.find_files{}<cr>

autocmd FileType TelescopePrompt nmap <buffer> ç <Esc>

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<Tab>"] = actions.move_selection_next,
        -- ["<S-Tab>"] = actions.move_selection_previous,
        -- ["<C-Space>"] = actions.close,
        ["<C-Space>"] = actions.close,

        -- TODO: When we implement multi-select, you can turn this back on :)
        ["<Tab>"] = actions.add_selection,
      },
      n = {
        ["<C-Space>"] = actions.close,
      },
    },
  }
}
EOF

function! s:set_telescope_colors() abort

  if g:colors_name ==# 'gruvbox'
    let g:gui_foreground  = '#FB4934'
  elseif g:colors_name ==# 'vim-material'
    let g:gui_foreground  = '#89DDFF'
  else
    let g:gui_foreground  = '#CCCCCC'
  endif

  highlight TelescopeSelection      guifg=#D79921 gui=bold
  highlight TelescopeSelectionCaret guifg=blue
  highlight TelescopeMultiSelection guifg=#928374
  highlight TelescopeNormal         guibg=none

  " Used for highlighting characters that you match.
  " highlight TelescopeMatching       guifg=blue
  exe "highlight TelescopeMatching " . "guifg=" . g:gui_foreground

  " Used for the prompt prefix
  highlight TelescopePromptPrefix   guifg=red

  function! s:set_telescope_border() abort
    if g:colors_name ==# 'gruvbox'
      let g:gui_foreground  = '#FE8019'
    elseif g:colors_name ==# 'vim-material'
      let g:gui_foreground  = '#89DDFF'
    else
      let g:gui_foreground  = '#CCCCCC'
    endif

    exe "highlight TelescopeBorder         " . "guifg=" . g:gui_foreground
    exe "highlight TelescopePromptBorder   " . "guifg=" . g:gui_foreground
    exe "highlight TelescopeResultsBorder  " . "guifg=" . g:gui_foreground
    exe "highlight TelescopePreviewBorder  " . "guifg=" . g:gui_foreground
  endfunction

  call s:set_telescope_border()
endfunction

call s:set_telescope_colors()
