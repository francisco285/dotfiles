local set_map = require("autoload.util").set_map
local map = {}

function map.buffer()
  set_map('n', { '[b', '<Leader>p', '<Left>', '<C-PageUp>' }, [['<Cmd>bprevious ' . v:count1 . '<CR>']], { expr = true })
  set_map('n', { ']b', '<Leader>n',  '<Right>', '<C-PageDown>' }, [['<Cmd>bnext ' . v:count1 . '<CR>']], { expr = true })

  set_map('n', { '[B', '<Leader>P' }, [[<Cmd>bfirst<CR>]])
  set_map('n', { ']B', '<Leader>N' }, [[<Cmd>blast<CR>]])

  set_map('n', '<Leader><BS>', [[<Cmd>bd<CR>]])
  set_map('n', '<Leader>o', [[<Cmd>lua require('autoload.buffer').delete_hidden()<CR>]])
end

function map.window()
  set_map({ 'n', 't' }, '<M-h>', [[<Cmd>wincmd h<CR>]])
  set_map({ 'n', 't' }, '<M-l>', [[<Cmd>wincmd l<CR>]])
  set_map({ 'n', 't' }, '<M-j>', [[<Cmd>wincmd j<CR>]])
  set_map({ 'n', 't' }, '<M-k>', [[<Cmd>wincmd k<CR>]])

  set_map({ 'n', 't' }, '<M-H>', [[<Cmd>wincmd H<CR>]])
  set_map({ 'n', 't' }, '<M-J>', [[<Cmd>wincmd J<CR>]])
  set_map({ 'n', 't' }, '<M-K>', [[<Cmd>wincmd K<CR>]])
  set_map({ 'n', 't' }, '<M-L>', [[<Cmd>wincmd L<CR>]])

  set_map({ 'n', 't' }, '<M-(>', [[<Cmd>wincmd <<CR>]])
  set_map({ 'n', 't' }, '<M-->', [[<Cmd>wincmd -<CR>]])
  set_map({ 'n', 't' }, '<M-+>', [[<Cmd>wincmd +<CR>]])
  set_map({ 'n', 't' }, '<M-)>', [[<Cmd>wincmd ><CR>]])

  set_map({ 'n', 't' }, '<M-=>', [[<Cmd>wincmd =<CR>]])

  set_map('n', '<M-c>', [[<Cmd>close<CR>]])
  set_map('n', '<M-o>', [[<Cmd>wincmd o<CR>]])
  set_map('n', '<M-w>', [[<Cmd>wincmd w<CR>]])
  set_map('n', { '<M-s>h', '<M-s><M-h>' }, [[<Cmd>above vertical split<CR>]])
  set_map('n', { '<M-s>j', '<M-s><M-j>' }, [[<Cmd>below          split<CR>]])
  set_map('n', { '<M-s>k', '<M-s><M-k>' }, [[<Cmd>above          split<CR>]])
  set_map('n', { '<M-s>l', '<M-s><M-l>' }, [[<Cmd>below vertical split<CR>]])
end

function map.tab()
  set_map('n', '[t', [[<Cmd>tabprevious<CR>]])
  set_map('n', ']t', [[<Cmd>tabnext<CR>]])
  set_map('n', '[T', [[<Cmd>tabfirst<CR>]])
  set_map('n', ']T', [[<Cmd>tablast<CR>]])

  set_map('n', '<Left>', [[<Cmd>tabprevious<CR>]])
  set_map('n', '<Right>', [[<Cmd>tabnext<CR>]])
end

function map.terminal()
  set_map('t', '<M-,><M-,>', [[<c-\><c-n>]], { noremap = true })

  set_map({ 't', 'n' }, { '<M-,>sh', '<M-,><M-s>h', '<M-,><M-s><M-h>' }, [[<Cmd>above vertical split <Bar> terminal <CR>]])
  set_map({ 't', 'n' }, { '<M-,>sj', '<M-,><M-s>j', '<M-,><M-s><M-j>' }, [[<Cmd>below          split <Bar> terminal <CR>]])
  set_map({ 't', 'n' }, { '<M-,>sk', '<M-,><M-s>k', '<M-,><M-s><M-k>' }, [[<Cmd>above          split <Bar> terminal <CR>]])
  set_map({ 't', 'n' }, { '<M-,>sl', '<M-,><M-s>l', '<M-,><M-s><M-l>' }, [[<Cmd>below vertical split <Bar> terminal <CR>]])

  set_map('n', '<M-,>r', [[<Cmd>lua require('autoload.terminal').run_file('tab split <Bar> terminal')<CR>]])
  set_map('n', '<M-,>R', [[<Cmd>lua require('autoload.terminal').open_repl('', 'tab split <Bar> terminal')<CR>]])
end

function map.command_line()
  set_map('c', '<C-h>', [[pumvisible() ? "\<Up>": "\<Left>"]], { noremap = true, expr = true })
  set_map('c', '<C-j>', [[pumvisible() ? "\<Right>": "\<Down>"]], { noremap = true, expr = true })
  set_map('c', '<C-k>', [[pumvisible() ? "\<Left>": "\<Up>"]], { noremap = true, expr = true })
  set_map('c', '<C-l>', [[pumvisible() ? "\<Down>": "\<Right>"]], { noremap = true, expr = true })
  set_map('c', '<C-f>', [[<S-right>]], { noremap = true })
  set_map('c', '<C-_>', [[<C-f>]], { noremap = true })
  set_map('c', '<C-b>', [[<S-left>]], { noremap = true })
  set_map('c', '<C-a>', [[<Home>]], { noremap = true })
  set_map('c', '<C-e>', [[<End>]], { noremap = true })
  set_map("c", '<C-Space>', [[<C-R>=fnamemodify(expand('%:p:h'), ':~:.') ==? '' ? '~' : fnamemodify(expand('%:p:h'), ':~:.')<CR>/]], { noremap = true })
  set_map("c", '<C-d>', [[getcmdpos() > strlen(getcmdline()) ? "\<lt>C-d>" : "\<lt>Del>"]], { noremap = true, expr = true })
end

function map.qf()
  set_map('n', '<Bslash>q', [[<Cmd>copen<CR>]])
  set_map('n', '<C-h>', [[<Cmd>cnext<CR>]])
  set_map('n', '<C-l>', [[<Cmd>cprevious<CR>]])

  set_map('n', '<Bslash>l', [[<Cmd>lopen<CR>]])
  set_map('n', '<C-j>', [[<Cmd>lnext<CR>]])
  set_map('n', '<C-k>', [[<Cmd>lprevious<CR>]])
end

function map.black_hole()
  set_map({'n', 'x'}, '<Bslash><Bslash>', [["_]], { noremap = true })
  set_map('v', '<Leader>d', [["_d]], { noremap = true })
  set_map('v', '<Leader>p', [["_dp]], { noremap = true })
  set_map('v', '<Leader>D', [["_D]], { noremap = true })
  set_map('v', '<Leader>P', [["_dP]], { noremap = true })
end

function map.insert()
  set_map('i', '<C-h>', [[<Left>]], { noremap = true })
  set_map('i', '<C-l>', [[<Right>]], { noremap = true })
  set_map('i', '<C-d>', [[<Del>]], { noremap = true })
  set_map('i', '<C-b>', [[<S-Left>]], { noremap = true })
  set_map('i', '<C-f>', [[<S-Right>]], { noremap = true })
  set_map('i', '<C-a>', [[<C-o>I]], { noremap = true })
  set_map('i', '<C-e>', [[pumvisible() ? "\<C-e>" : "\<End>"]], { noremap = true, expr = true })
  set_map('i', '<C-s>', [[<Cmd>update<CR>]])
end

function map.enhance()
  set_map('n', '<Up>', [[<C-y>]], { noremap = true })
  set_map('n', '<Down>', [[<C-e>]], { noremap = true })
  set_map('n', '/', [[/\v]], { noremap = true })
  set_map('n', '!', [[:!]], { noremap = true })
  set_map('n', 'Q', [[@q]], { noremap = true })

  -- From http://vi.stackexchange.com/a/213
  -- via https://github.com/tjdevries/config_manager/blob/d9f83f4affb2fe51bed183f1198251a6466e98fe/xdg_config/nvim/plugin/keymaps.vim#L42-L46
  set_map('n', 'gj', [[:let _ = &lazyredraw <Bar> set lazyredraw<CR>/\%<C-R>=virtcol('.')<CR>v\S<CR>:nohl<CR>:let &lazyredraw = _<CR>]], { noremap = true, silent = true })
  set_map('n', 'gk', [[:let _ = &lazyredraw <Bar> set lazyredraw<CR>?\%<C-R>=virtcol('.')<CR>v\S<CR>:nohl<CR>:let &lazyredraw = _<CR>]], { noremap = true, silent = true })

  -- Better j and k for wrap mode
  set_map('n', 'j', [[v:count == 0 ? 'gj' : 'j']], { noremap = true, expr = true })
  set_map('n', 'k', [[v:count == 0 ? 'gk' : 'k']], { noremap = true, expr = true })

  -- Change indentation in visual mode without leaving it
  set_map('v', '>', [[>gv]], { noremap = true })
  set_map('v', '<', [[<gv]], { noremap = true })

  -- Make Y behavior consistent with C and D
  set_map('n', 'Y', [[y$]], { noremap = true })
end

function map.editing()
  set_map('n', '<Bslash>w', [[<Cmd>update<CR>]])

  -- Undo/Redo but only considering written changes.
  set_map('n', '[w', [['<Cmd>earlier ' . v:count1 . 'f<CR>']], { expr = true })
  set_map('n', ']w', [['<Cmd>later   ' . v:count1 . 'f<CR>']], { expr = true })
  set_map('n', '[W', [[<Cmd>earlier 9999f<CR>]])
  set_map('n', ']W', [[<Cmd>later   9999f<CR>]])

  set_map('v', '<Bslash>s', [[:s///g<Left><Left><Left>]], { noremap = true })
  set_map('v', '<Bslash>g', [[:g/.*/normal<Space>]], { noremap = true })

  -- https://github.com/tpope/vim-unimpaired/pull/164
  set_map('n', '[<Space>', [[<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>]])
  set_map('n', ']<Space>', [[<Cmd>call append(line('.'), repeat([''], v:count1))<CR>]])

  set_map('n', '<M-BS>', [[<Cmd>keeppatterns %substitute/\s\+$//ec<CR>]])

  -- from https://github.com/tpope/tpope/blob/d0c97ebf32f34f2791e55e2fb49657a248ad8b13/.vimrc#L209-L210
  -- via https://github.com/justinmk/config/blob/1932d802b7a69bf520ecae0296b070dd5563343f/.config/nvim/init.vim#L855-L858
  set_map('i', '<C-g><C-t>', [[<C-R>=repeat(complete(col('.'), map(['%Y-%m-%d %H:%M:%S', '%a, %d %b %Y %H:%M:%S %z', '%Y %b %d', '%d-%b-%y', '%a %b %d %T %Z %Y'], 'strftime(v:val)') + [localtime()]), 0)<CR>]], { noremap = true })
end

function map.option()
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
  map_toggle('u', 'cursorcolumn')
  map_toggle('w', 'wrap')
  map_toggle('f', 'foldlevel', 'let &foldlevel = &foldlevel != 0 ? 0 : 99')
  map_toggle('-', 'showtabline', 'let &showtabline = &showtabline == 2 ? 0 : 2')
  map_toggle('_', 'laststatus', 'let &laststatus = &laststatus == 2 ? 0 : 2')
end

function map.miscellaneous()
  -- Highlight and search ocurrences of the current word but do not make cursor
  -- jump
  -- https://stackoverflow.com/a/13682379
  set_map('n', '<C-_>', [[:let @/='<C-R>=expand('<cword>')<CR>' <Bar> set hlsearch<CR>]], { noremap = true, silent = true })
  set_map('n', '<M-/>', [[:let @/='\<<C-R>=expand('<cword>')<CR>\>'<CR>:set hlsearch<CR>]], { noremap = true, silent = true })

  -- Toggle hlsearch without actually changing the option
  set_map('n', '<CR>', [[&buftype == '' || &buftype == 'help' ? '<Cmd>let v:hlsearch = !v:hlsearch<CR>' : "<CR>"]], { noremap = true, expr = true })

  set_map({ 'i', 'c' }, '<M-v>', [[<C-v>]], { noremap = true })
  set_map({ 'i', 'n', 'c' }, '<M-m>', [[<Cmd>suspend<CR>]])

  -- Last command used on command-line
  set_map('n', 'cm', [[:<Up>]], { noremap = true })

  -- Change current working directory
  -- https://github.com/justinmk/config/blob/1932d802b7a69bf520ecae0296b070dd5563343f/.config/nvim/init.vim#L511-L513
  set_map('n', 'cd', [[<Cmd>cd %:p:h <Bar> pwd<CR>]])
  set_map('n', 'cu', [[<Cmd>cd .. <Bar> pwd<CR>]])
end

for _, maps in pairs(map) do
  maps()
end
