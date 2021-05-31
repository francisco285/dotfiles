local map = require("autoload.util").set_map
local M = {}

function M.buffer()
  map('n', { '<M-p>', '[b', '<Leader>p', '<Left>', '<C-PageUp>' }, [['<Cmd>bprevious ' . v:count1 . '<CR>']], { expr = true })
  map('n', { '<M-n>', ']b', '<Leader>n',  '<Right>', '<C-PageDown>' }, [['<Cmd>bnext ' . v:count1 . '<CR>']], { expr = true })

  map('n', { '<M-P>', '[B', '<Leader>P' }, [[<Cmd>bfirst<CR>]])
  map('n', { '<M-N>', ']B', '<Leader>N' }, [[<Cmd>blast<CR>]])

  map('n', '<Leader><BS>', [[<Cmd>silent! bd<CR>]])
  map('n', '<Leader>o', [[<Cmd>lua require('autoload.buffer').delete_hidden()<CR>]])
end

function M.window()
  map({ 'n', 't' }, '<M-h>', [[<Cmd>wincmd h<CR>]])
  map({ 'n', 't' }, '<M-l>', [[<Cmd>wincmd l<CR>]])
  map({ 'n', 't' }, '<M-j>', [[<Cmd>wincmd j<CR>]])
  map({ 'n', 't' }, '<M-k>', [[<Cmd>wincmd k<CR>]])

  map({ 'n', 't' }, '<M-H>', [[<Cmd>wincmd H<CR>]])
  map({ 'n', 't' }, '<M-J>', [[<Cmd>wincmd J<CR>]])
  map({ 'n', 't' }, '<M-K>', [[<Cmd>wincmd K<CR>]])
  map({ 'n', 't' }, '<M-L>', [[<Cmd>wincmd L<CR>]])

  map({ 'n', 't' }, '<M-{>', [[<Cmd>wincmd <<CR>]])
  map({ 'n', 't' }, '<M-->', [[<Cmd>wincmd -<CR>]])
  map({ 'n', 't' }, '<M-+>', [[<Cmd>wincmd +<CR>]])
  map({ 'n', 't' }, '<M-}>', [[<Cmd>wincmd ><CR>]])

  map({ 'n', 't' }, '<M-=>', [[<Cmd>wincmd =<CR>]])

  map('n', '<M-w>', [[<C-w>]])
  map('n', { '<M-s>h', '<M-s><M-h>' }, [[<Cmd>above vertical split<CR>]])
  map('n', { '<M-s>j', '<M-s><M-j>' }, [[<Cmd>below          split<CR>]])
  map('n', { '<M-s>k', '<M-s><M-k>' }, [[<Cmd>above          split<CR>]])
  map('n', { '<M-s>l', '<M-s><M-l>' }, [[<Cmd>below vertical split<CR>]])
end

function M.tab()
  -- TODO: Set more tab related keymaps, e.g.: tabclose, tabonly, tabmove, etc...
  map('n', '<Leader><Tab>', [[<Cmd>tabnew<CR>]])

  map('n', '[t', [[<Cmd>tabprevious<CR>]])
  map('n', ']t', [[<Cmd>tabnext<CR>]])
  map('n', '[T', [[<Cmd>tabfirst<CR>]])
  map('n', ']T', [[<Cmd>tablast<CR>]])

  map('n', '<Left>', [[<Cmd>tabprevious<CR>]])
  map('n', '<Right>', [[<Cmd>tabnext<CR>]])
end

function M.terminal()
  map('t', '<M-,><M-,>', [[<c-\><c-n>]], { noremap = true })

  map({ 't', 'n' }, { '<M-,>sh', '<M-,><M-s>h', '<M-,><M-s><M-h>' }, [[<Cmd>above vertical split <Bar> terminal <CR>]])
  map({ 't', 'n' }, { '<M-,>sj', '<M-,><M-s>j', '<M-,><M-s><M-j>' }, [[<Cmd>below          split <Bar> terminal <CR>]])
  map({ 't', 'n' }, { '<M-,>sk', '<M-,><M-s>k', '<M-,><M-s><M-k>' }, [[<Cmd>above          split <Bar> terminal <CR>]])
  map({ 't', 'n' }, { '<M-,>sl', '<M-,><M-s>l', '<M-,><M-s><M-l>' }, [[<Cmd>below vertical split <Bar> terminal <CR>]])
end

function M.cmdline()
  map('c', '<C-h>', [[<C-w>]], { noremap = true })
  map('c', '<C-j>', [[<Down>]], { noremap = true })
  map('c', '<C-k>', [[<Up>]], { noremap = true })

  map('c', '<M-h>', [[pumvisible() ? "\<Up>" : "\<Left>"]], { noremap = true, expr = true })
  map('c', '<M-j>', [[pumvisible() ? "\<Right>" : "\<M-j>"]], { noremap = true, expr = true })
  map('c', '<M-k>', [[pumvisible() ? "\<Left>" : "\<M-k>"]], { noremap = true, expr = true })
  map('c', '<M-l>', [[pumvisible() ? "\<Down>" : "\<Right>"]], { noremap = true, expr = true })

  map('c', '<C-f>', [[<S-right>]], { noremap = true })
  map('c', '<C-b>', [[<S-left>]], { noremap = true })
  map('c', '<C-a>', [[<Home>]], { noremap = true })
  map('c', '<C-e>', [[<End>]], { noremap = true })

  map('c', '<M-f>', [[<C-f>]], { noremap = true })
  function _G.cmdline_get_buf_dir()
    local fn = vim.fn
    local buf_dir = fn.fnamemodify(fn.expand('%:p:h'), ':~:.')
    return fn.fnameescape((buf_dir == '' and '~' or buf_dir) .. fn.expand('/'))
  end
  -- map("c", '<C-Space>', [[<C-R>=fnamemodify(expand('%:p:h'), ':~:.') ==? '' ? '~' : fnamemodify(expand('%:p:h'), ':~:.')<CR>/]], { noremap = true })
  map("c", '<C-Space>', [[<C-R>=v:lua._G.cmdline_get_buf_dir()<CR>]], { noremap = true })
  map("c", '<C-d>', [[getcmdpos() > strlen(getcmdline()) ? "\<lt>C-d>" : "\<lt>Del>"]], { noremap = true, expr = true })
end

function M.qf()
  map('n', '<Bslash>q', [[<Cmd>copen<CR>]])
  map('n', '<C-h>', [[<Cmd>cprevious<CR>]])
  map('n', '<C-l>', [[<Cmd>cnext<CR>]])

  map('n', '<Bslash>l', [[<Cmd>lopen<CR>]])
  map('n', '<C-j>', [[<Cmd>lnext<CR>]])
  map('n', '<C-k>', [[<Cmd>lprevious<CR>]])
end

function M.black_hole()
  map({'n', 'x'}, '<Bslash><Bslash>', [["_]], { noremap = true })
  map('v', '<Leader>d', [["_d]], { noremap = true })
  map('v', '<Leader>p', [["_dp]], { noremap = true })
  map('v', '<Leader>D', [["_D]], { noremap = true })
  map('v', '<Leader>P', [["_dP]], { noremap = true })
end

function M.insert()
  map('i', '<C-h>', [[<C-w>]], { noremap = true })
  map('i', '<M-h>', [[<Left>]], { noremap = true })
  map('i', '<M-l>', [[<Right>]], { noremap = true })
end

function M.enhance()
  -- 'gf' by default will fail if Neovim can't find 'file' in $PATH
  map('n', 'gf', [[<Cmd>edit <cfile><CR>]])
  map('n', '<Up>', [[<C-y>]], { noremap = true })
  map('n', '<Down>', [[<C-e>]], { noremap = true })
  map('n', '/', [[/\v]], { noremap = true })
  map('n', '!', [[:!]], { noremap = true })
  map('n', 'Q', [[@q]], { noremap = true })

  -- From http://vi.stackexchange.com/a/213
  -- via https://github.com/tjdevries/config_manager/blob/d9f83f4affb2fe51bed183f1198251a6466e98fe/xdg_config/nvim/plugin/keymaps.vim#L42-L46
  map('n', 'gj', [[:let _ = &lazyredraw <Bar> set lazyredraw<CR>/\%<C-R>=virtcol('.')<CR>v\S<CR>:nohl<CR>:let &lazyredraw = _<CR>]], { noremap = true, silent = true })
  map('n', 'gk', [[:let _ = &lazyredraw <Bar> set lazyredraw<CR>?\%<C-R>=virtcol('.')<CR>v\S<CR>:nohl<CR>:let &lazyredraw = _<CR>]], { noremap = true, silent = true })

  -- Better j and k for wrap mode
  map('n', 'j', [[v:count == 0 ? 'gj' : 'j']], { noremap = true, expr = true })
  map('n', 'k', [[v:count == 0 ? 'gk' : 'k']], { noremap = true, expr = true })

  -- Change indentation in visual mode without leaving it
  map('v', '>', [[>gv]], { noremap = true })
  map('v', '<', [[<gv]], { noremap = true })

  -- Make Y behavior consistent with C and D
  map('n', 'Y', [[y$]], { noremap = true })
end

function M.editing()
  -- set_map('n', '<Bslash>w', [[<Cmd>update<CR>]])

  -- Undo/Redo but only considering written changes.
  map('n', '[w', [['<Cmd>earlier ' . v:count1 . 'f<CR>']], { expr = true })
  map('n', ']w', [['<Cmd>later   ' . v:count1 . 'f<CR>']], { expr = true })
  map('n', '[W', [[<Cmd>earlier 9999f<CR>]])
  map('n', ']W', [[<Cmd>later   9999f<CR>]])

  map('v', '<Bslash>s', [[:s///g<Left><Left><Left>]], { noremap = true })
  map('v', '<Bslash>g', [[:g/.*/normal<Space>]], { noremap = true })

  -- https://github.com/tpope/vim-unimpaired/pull/164
  map('n', '[<Space>', [[<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>]])
  map('n', ']<Space>', [[<Cmd>call append(line('.'), repeat([''], v:count1))<CR>]])

  map('n', '<M-BS>', [[<Cmd>keeppatterns %substitute/\s\+$//ec<CR>]])

  -- from https://github.com/tpope/tpope/blob/d0c97ebf32f34f2791e55e2fb49657a248ad8b13/.vimrc#L209-L210
  -- via https://github.com/justinmk/config/blob/1932d802b7a69bf520ecae0296b070dd5563343f/.config/nvim/init.vim#L855-L858
  map('i', '<C-g><C-t>', [[<C-R>=repeat(complete(col('.'), map(['%Y-%m-%d %H:%M:%S', '%a, %d %b %Y %H:%M:%S %z', '%Y %b %d', '%d-%b-%y', '%a %b %d %T %Z %Y'], 'strftime(v:val)') + [localtime()]), 0)<CR>]], { noremap = true })
end

function M.option()
  -- " https://github.com/junegunn/dotfiles/blob/18e886d73eac4866724cfcb00ef168dffd5be0d4/vimrc#L1014-L1021
  local function map_toggle(key, opt, cmd)
    local lhs = string.format('co%s', key)
    local rhs

    if cmd then
      rhs = string.format('<Cmd>%s <Bar> set %s? <CR>', cmd, opt)
    else
      rhs = string.format('<Cmd>set %s! <Bar> set %s?<CR>', opt, opt)
    end

    vim.api.nvim_set_keymap('n', lhs, rhs, {})
  end

  map_toggle('b', 'background', 'let &background = &background == "dark" ? "light" : "dark" <Bar> redraw')
  map_toggle('c', 'cursorline')
  map_toggle('h', 'hlsearch')
  map_toggle('l', 'list')
  map_toggle('n', 'number')
  map_toggle('r', 'relativenumber')
  map_toggle('s', 'spell')
  map_toggle('S', 'signcolumn', 'let &signcolumn = &signcolumn == "no" ? "yes" : "no"')
  map_toggle('u', 'cursorcolumn')
  map_toggle('w', 'wrap')
  map_toggle('f', 'foldlevel', 'let &foldlevel = &foldlevel != 0 ? 0 : 99')
  map_toggle('-', 'showtabline', 'let &showtabline = &showtabline == 2 ? 0 : 2')
  map_toggle('_', 'laststatus', 'let &laststatus = &laststatus == 2 ? 0 : 2')
end

function M.misc()
  -- Useful for a lot of plugins that sets buffer-local maps
  map('n', '<Leader>?', [[<Cmd>nmap <buffer><CR>]])

  -- Highlight and search ocurrences of the current word but do not make cursor jump
  -- https://stackoverflow.com/a/13682379
  map('n', '<C-_>', [[:silent! let @/='<C-R>=expand('<cword>')<CR>' <Bar> set hlsearch<CR>]], { noremap = true, silent = true })
  map('n', '<M-/>', [[:silent! let @/='\<<C-R>=expand('<cword>')<CR>\>' <Bar> set hlsearch<CR>]], { noremap = true, silent = true })

  -- Toggle hlsearch without actually changing the option
  map('n', '<CR>', [[&buftype != 'quickfix' && &buftype != 'prompt' ? '<Cmd>let v:hlsearch = !v:hlsearch<CR>' : "<CR>"]], { noremap = true, expr = true })

  map({ 'i', 'c' }, '<M-v>', [[<C-v>]], { noremap = true })
  map({ 'i', 'n', 'c' }, '<M-m>', [[<Cmd>suspend<CR>]])

  -- Last command used on command-line
  map('n', 'cm', [[:<Up>]], { noremap = true })

  -- Change current working directory
  -- https://github.com/justinmk/config/blob/1932d802b7a69bf520ecae0296b070dd5563343f/.config/nvim/init.vim#L511-L513
  map('n', 'cd', [[<Cmd>cd %:p:h <Bar> pwd<CR>]])
  map('n', 'cu', [[<Cmd>cd .. <Bar> pwd<CR>]])

  map('v', 'K', [[:m '<-2<CR>gv=gv]], { noremap = true })
  map('v', 'J', [[:m '>+1<CR>gv=gv]], { noremap = true })
end

for _, maps in pairs(M) do
  maps()
end
