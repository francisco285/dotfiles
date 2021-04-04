lua << EOF
local save_laststatus = vim.o.laststatus
vim.o.laststatus = 0
vim.cmd('autocmd BufLeave <buffer> lua vim.o.laststatus = ' .. save_laststatus)
EOF
