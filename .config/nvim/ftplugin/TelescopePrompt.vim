lua << EOF
local save_hlsearch = vim.o.hlsearch
vim.o.hlsearch = false
vim.cmd(string.format('autocmd WinLeave <buffer> lua vim.o.hlsearch = %s', save_hlsearch))
EOF
