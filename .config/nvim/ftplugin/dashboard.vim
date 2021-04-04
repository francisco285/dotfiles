lua << EOF
vim.wo.cursorline = true
local save_showtabline, save_laststatus = vim.o.showtabline, vim.o.laststatus
vim.o.showtabline = 0
vim.o.laststatus = 0
vim.cmd(string.format('autocmd WinLeave,BufLeave <buffer> lua vim.o.showtabline, vim.o.laststatus = %s, %s', save_showtabline, save_laststatus))

local map = vim.api.nvim_buf_set_keymap

map(0, 'n', 'q', '<Cmd>quit<CR>', {})
map(0, 'n', '1', '<Cmd>DashboardJumpMark<CR>', {})
map(0, 'n', '2', '<Cmd>DashboardChangeColorscheme<CR>', {})
map(0, 'n', '3', '<Cmd>DashboardFindFile<CR>', {})
map(0, 'n', '4', '<Cmd>DashboardFindHistory<CR>', {})
map(0, 'n', '5', '<Cmd>DashboardFindWord<CR>', {})
map(0, 'n', '6', '<Cmd>SessionLoad<CR>', {})
map(0, 'n', '7', '<Cmd>DashboardNewFile<CR>', {})
EOF
